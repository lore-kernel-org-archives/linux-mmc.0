From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc_test: use ktime_get_ts64 for timestamps
Date: Thu, 30 Nov 2017 14:10:02 +0100
Message-ID: <CAPDyKFqH70R=mZBa=mEW20Pgdmvy0AzUVGnE0qz-uAVToqzsDw@mail.gmail.com>
References: <20171127115411.2939489-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171127115411.2939489-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, y2038@lists.linaro.org, Shawn Lin <shawn.lin@rock-chips.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 27 November 2017 at 12:53, Arnd Bergmann <arnd@arndb.de> wrote:
> Calling getnstimeofday() can suffer from time jumps and from the
> y2038 overflow, so it is not appropriate here. Using ktime_get_ts64()
> solves both problems. Using ktime_get() with ktime_t timestamps would
> also work, but it seems that we mainly want to print the times as
> seconds+nanoseconds, so it would require an extra division in the output.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc_test.c | 88 ++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 478869805b96..eae8810d22d9 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -101,7 +101,7 @@ struct mmc_test_transfer_result {
>         struct list_head link;
>         unsigned int count;
>         unsigned int sectors;
> -       struct timespec ts;
> +       struct timespec64 ts;
>         unsigned int rate;
>         unsigned int iops;
>  };
> @@ -515,14 +515,11 @@ static int mmc_test_map_sg_max_scatter(struct mmc_test_mem *mem,
>  /*
>   * Calculate transfer rate in bytes per second.
>   */
> -static unsigned int mmc_test_rate(uint64_t bytes, struct timespec *ts)
> +static unsigned int mmc_test_rate(uint64_t bytes, struct timespec64 *ts)
>  {
>         uint64_t ns;
>
> -       ns = ts->tv_sec;
> -       ns *= 1000000000;
> -       ns += ts->tv_nsec;
> -
> +       ns = timespec64_to_ns(ts);
>         bytes *= 1000000000;
>
>         while (ns > UINT_MAX) {
> @@ -542,7 +539,7 @@ static unsigned int mmc_test_rate(uint64_t bytes, struct timespec *ts)
>   * Save transfer results for future usage
>   */
>  static void mmc_test_save_transfer_result(struct mmc_test_card *test,
> -       unsigned int count, unsigned int sectors, struct timespec ts,
> +       unsigned int count, unsigned int sectors, struct timespec64 ts,
>         unsigned int rate, unsigned int iops)
>  {
>         struct mmc_test_transfer_result *tr;
> @@ -567,21 +564,21 @@ static void mmc_test_save_transfer_result(struct mmc_test_card *test,
>   * Print the transfer rate.
>   */
>  static void mmc_test_print_rate(struct mmc_test_card *test, uint64_t bytes,
> -                               struct timespec *ts1, struct timespec *ts2)
> +                               struct timespec64 *ts1, struct timespec64 *ts2)
>  {
>         unsigned int rate, iops, sectors = bytes >> 9;
> -       struct timespec ts;
> +       struct timespec64 ts;
>
> -       ts = timespec_sub(*ts2, *ts1);
> +       ts = timespec64_sub(*ts2, *ts1);
>
>         rate = mmc_test_rate(bytes, &ts);
>         iops = mmc_test_rate(100, &ts); /* I/O ops per sec x 100 */
>
> -       pr_info("%s: Transfer of %u sectors (%u%s KiB) took %lu.%09lu "
> +       pr_info("%s: Transfer of %u sectors (%u%s KiB) took %llu.%09u "
>                          "seconds (%u kB/s, %u KiB/s, %u.%02u IOPS)\n",
>                          mmc_hostname(test->card->host), sectors, sectors >> 1,
> -                        (sectors & 1 ? ".5" : ""), (unsigned long)ts.tv_sec,
> -                        (unsigned long)ts.tv_nsec, rate / 1000, rate / 1024,
> +                        (sectors & 1 ? ".5" : ""), (u64)ts.tv_sec,
> +                        (u32)ts.tv_nsec, rate / 1000, rate / 1024,
>                          iops / 100, iops % 100);
>
>         mmc_test_save_transfer_result(test, 1, sectors, ts, rate, iops);
> @@ -591,24 +588,24 @@ static void mmc_test_print_rate(struct mmc_test_card *test, uint64_t bytes,
>   * Print the average transfer rate.
>   */
>  static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
> -                                   unsigned int count, struct timespec *ts1,
> -                                   struct timespec *ts2)
> +                                   unsigned int count, struct timespec64 *ts1,
> +                                   struct timespec64 *ts2)
>  {
>         unsigned int rate, iops, sectors = bytes >> 9;
>         uint64_t tot = bytes * count;
> -       struct timespec ts;
> +       struct timespec64 ts;
>
> -       ts = timespec_sub(*ts2, *ts1);
> +       ts = timespec64_sub(*ts2, *ts1);
>
>         rate = mmc_test_rate(tot, &ts);
>         iops = mmc_test_rate(count * 100, &ts); /* I/O ops per sec x 100 */
>
>         pr_info("%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
> -                        "%lu.%09lu seconds (%u kB/s, %u KiB/s, "
> +                        "%llu.%09u seconds (%u kB/s, %u KiB/s, "
>                          "%u.%02u IOPS, sg_len %d)\n",
>                          mmc_hostname(test->card->host), count, sectors, count,
>                          sectors >> 1, (sectors & 1 ? ".5" : ""),
> -                        (unsigned long)ts.tv_sec, (unsigned long)ts.tv_nsec,
> +                        (u64)ts.tv_sec, (u32)ts.tv_nsec,
>                          rate / 1000, rate / 1024, iops / 100, iops % 100,
>                          test->area.sg_len);
>
> @@ -1449,7 +1446,7 @@ static int mmc_test_area_io_seq(struct mmc_test_card *test, unsigned long sz,
>                                 int max_scatter, int timed, int count,
>                                 bool nonblock, int min_sg_len)
>  {
> -       struct timespec ts1, ts2;
> +       struct timespec64 ts1, ts2;
>         int ret = 0;
>         int i;
>         struct mmc_test_area *t = &test->area;
> @@ -1475,7 +1472,7 @@ static int mmc_test_area_io_seq(struct mmc_test_card *test, unsigned long sz,
>                 return ret;
>
>         if (timed)
> -               getnstimeofday(&ts1);
> +               ktime_get_ts64(&ts1);
>         if (nonblock)
>                 ret = mmc_test_nonblock_transfer(test, t->sg, t->sg_len,
>                                  dev_addr, t->blocks, 512, write, count);
> @@ -1489,7 +1486,7 @@ static int mmc_test_area_io_seq(struct mmc_test_card *test, unsigned long sz,
>                 return ret;
>
>         if (timed)
> -               getnstimeofday(&ts2);
> +               ktime_get_ts64(&ts2);
>
>         if (timed)
>                 mmc_test_print_avg_rate(test, sz, count, &ts1, &ts2);
> @@ -1747,7 +1744,7 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
>         struct mmc_test_area *t = &test->area;
>         unsigned long sz;
>         unsigned int dev_addr;
> -       struct timespec ts1, ts2;
> +       struct timespec64 ts1, ts2;
>         int ret;
>
>         if (!mmc_can_trim(test->card))
> @@ -1758,19 +1755,19 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
>
>         for (sz = 512; sz < t->max_sz; sz <<= 1) {
>                 dev_addr = t->dev_addr + (sz >> 9);
> -               getnstimeofday(&ts1);
> +               ktime_get_ts64(&ts1);
>                 ret = mmc_erase(test->card, dev_addr, sz >> 9, MMC_TRIM_ARG);
>                 if (ret)
>                         return ret;
> -               getnstimeofday(&ts2);
> +               ktime_get_ts64(&ts2);
>                 mmc_test_print_rate(test, sz, &ts1, &ts2);
>         }
>         dev_addr = t->dev_addr;
> -       getnstimeofday(&ts1);
> +       ktime_get_ts64(&ts1);
>         ret = mmc_erase(test->card, dev_addr, sz >> 9, MMC_TRIM_ARG);
>         if (ret)
>                 return ret;
> -       getnstimeofday(&ts2);
> +       ktime_get_ts64(&ts2);
>         mmc_test_print_rate(test, sz, &ts1, &ts2);
>         return 0;
>  }
> @@ -1779,19 +1776,19 @@ static int mmc_test_seq_read_perf(struct mmc_test_card *test, unsigned long sz)
>  {
>         struct mmc_test_area *t = &test->area;
>         unsigned int dev_addr, i, cnt;
> -       struct timespec ts1, ts2;
> +       struct timespec64 ts1, ts2;
>         int ret;
>
>         cnt = t->max_sz / sz;
>         dev_addr = t->dev_addr;
> -       getnstimeofday(&ts1);
> +       ktime_get_ts64(&ts1);
>         for (i = 0; i < cnt; i++) {
>                 ret = mmc_test_area_io(test, sz, dev_addr, 0, 0, 0);
>                 if (ret)
>                         return ret;
>                 dev_addr += (sz >> 9);
>         }
> -       getnstimeofday(&ts2);
> +       ktime_get_ts64(&ts2);
>         mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
>         return 0;
>  }
> @@ -1818,7 +1815,7 @@ static int mmc_test_seq_write_perf(struct mmc_test_card *test, unsigned long sz)
>  {
>         struct mmc_test_area *t = &test->area;
>         unsigned int dev_addr, i, cnt;
> -       struct timespec ts1, ts2;
> +       struct timespec64 ts1, ts2;
>         int ret;
>
>         ret = mmc_test_area_erase(test);
> @@ -1826,14 +1823,14 @@ static int mmc_test_seq_write_perf(struct mmc_test_card *test, unsigned long sz)
>                 return ret;
>         cnt = t->max_sz / sz;
>         dev_addr = t->dev_addr;
> -       getnstimeofday(&ts1);
> +       ktime_get_ts64(&ts1);
>         for (i = 0; i < cnt; i++) {
>                 ret = mmc_test_area_io(test, sz, dev_addr, 1, 0, 0);
>                 if (ret)
>                         return ret;
>                 dev_addr += (sz >> 9);
>         }
> -       getnstimeofday(&ts2);
> +       ktime_get_ts64(&ts2);
>         mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
>         return 0;
>  }
> @@ -1864,7 +1861,7 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
>         struct mmc_test_area *t = &test->area;
>         unsigned long sz;
>         unsigned int dev_addr, i, cnt;
> -       struct timespec ts1, ts2;
> +       struct timespec64 ts1, ts2;
>         int ret;
>
>         if (!mmc_can_trim(test->card))
> @@ -1882,7 +1879,7 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
>                         return ret;
>                 cnt = t->max_sz / sz;
>                 dev_addr = t->dev_addr;
> -               getnstimeofday(&ts1);
> +               ktime_get_ts64(&ts1);
>                 for (i = 0; i < cnt; i++) {
>                         ret = mmc_erase(test->card, dev_addr, sz >> 9,
>                                         MMC_TRIM_ARG);
> @@ -1890,7 +1887,7 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
>                                 return ret;
>                         dev_addr += (sz >> 9);
>                 }
> -               getnstimeofday(&ts2);
> +               ktime_get_ts64(&ts2);
>                 mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
>         }
>         return 0;
> @@ -1912,7 +1909,7 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
>  {
>         unsigned int dev_addr, cnt, rnd_addr, range1, range2, last_ea = 0, ea;
>         unsigned int ssz;
> -       struct timespec ts1, ts2, ts;
> +       struct timespec64 ts1, ts2, ts;
>         int ret;
>
>         ssz = sz >> 9;
> @@ -1921,10 +1918,10 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
>         range1 = rnd_addr / test->card->pref_erase;
>         range2 = range1 / ssz;
>
> -       getnstimeofday(&ts1);
> +       ktime_get_ts64(&ts1);
>         for (cnt = 0; cnt < UINT_MAX; cnt++) {
> -               getnstimeofday(&ts2);
> -               ts = timespec_sub(ts2, ts1);
> +               ktime_get_ts64(&ts2);
> +               ts = timespec64_sub(ts2, ts1);
>                 if (ts.tv_sec >= 10)
>                         break;
>                 ea = mmc_test_rnd_num(range1);
> @@ -1998,7 +1995,7 @@ static int mmc_test_seq_perf(struct mmc_test_card *test, int write,
>  {
>         struct mmc_test_area *t = &test->area;
>         unsigned int dev_addr, i, cnt, sz, ssz;
> -       struct timespec ts1, ts2;
> +       struct timespec64 ts1, ts2;
>         int ret;
>
>         sz = t->max_tfr;
> @@ -2025,7 +2022,7 @@ static int mmc_test_seq_perf(struct mmc_test_card *test, int write,
>         cnt = tot_sz / sz;
>         dev_addr &= 0xffff0000; /* Round to 64MiB boundary */
>
> -       getnstimeofday(&ts1);
> +       ktime_get_ts64(&ts1);
>         for (i = 0; i < cnt; i++) {
>                 ret = mmc_test_area_io(test, sz, dev_addr, write,
>                                        max_scatter, 0);
> @@ -2033,7 +2030,7 @@ static int mmc_test_seq_perf(struct mmc_test_card *test, int write,
>                         return ret;
>                 dev_addr += ssz;
>         }
> -       getnstimeofday(&ts2);
> +       ktime_get_ts64(&ts2);
>
>         mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
>
> @@ -3066,10 +3063,9 @@ static int mtf_test_show(struct seq_file *sf, void *data)
>                 seq_printf(sf, "Test %d: %d\n", gr->testcase + 1, gr->result);
>
>                 list_for_each_entry(tr, &gr->tr_lst, link) {
> -                       seq_printf(sf, "%u %d %lu.%09lu %u %u.%02u\n",
> +                       seq_printf(sf, "%u %d %llu.%09u %u %u.%02u\n",
>                                 tr->count, tr->sectors,
> -                               (unsigned long)tr->ts.tv_sec,
> -                               (unsigned long)tr->ts.tv_nsec,
> +                               (u64)tr->ts.tv_sec, (u32)tr->ts.tv_nsec,
>                                 tr->rate, tr->iops / 100, tr->iops % 100);
>                 }
>         }
> --
> 2.9.0
>
