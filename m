From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: RE: [PATCH 3/3] mmc_test: add tests to measure large sequential I/O performance
Date: Wed, 30 Mar 2011 16:27:18 +0530
Message-ID: <827b252b95aecd092f0c02ff635a924b@mail.gmail.com>
References: <1297165263-656-1-git-send-email-adrian.hunter@nokia.com> <1297165263-656-4-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43579 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754193Ab1C3K51 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 06:57:27 -0400
Received: by mail-bw0-f45.google.com with SMTP id 16so968915bwz.32
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 03:57:26 -0700 (PDT)
In-Reply-To: <1297165263-656-4-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
[mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Adrian
> Hunter
> Sent: Tuesday, February 08, 2011 5:11 PM
> To: Chris Ball
> Cc: Adrian Hunter; linux-mmc Mailing List
> Subject: [PATCH 3/3] mmc_test: add tests to measure large sequential I/O
performance
>
> Add two large sequential I/O performance tests:
>         35. Large sequential read into scattered pages
>         36. Large sequential write from scattered pages
>
> The tests measure transfer times for 10MiB, 100MiB, 1000MiB.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
>  drivers/mmc/card/mmc_test.c |  100
+++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 100 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index d1aa57a..5ec8edd 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -1871,6 +1871,92 @@ static int mmc_test_random_write_perf(struct
mmc_test_card *test)
>  	return mmc_test_random_perf(test, 1);
>  }
>
> +static int mmc_test_seq_perf(struct mmc_test_card *test, int write,
> +			     unsigned int tot_sz, int max_scatter)
> +{
> +	unsigned int dev_addr, i, cnt, sz, ssz;
> +	struct timespec ts1, ts2, ts;
> +	int ret;

Tabify all variable declarations.


> +
> +	sz = test->area.max_tfr;
> +	/*
> +	 * In the case of a maximally scattered transfer, the maximum
transfer
> +	 * size is further limited by using PAGE_SIZE segments.
> +	 */
> +	if (max_scatter) {
> +		struct mmc_test_area *t = &test->area;
> +		unsigned long max_tfr;
> +
> +		if (t->max_seg_sz >= PAGE_SIZE)
> +			max_tfr = t->max_segs * PAGE_SIZE;
> +		else
> +			max_tfr = t->max_segs * t->max_seg_sz;
> +		if (sz > max_tfr)
> +			sz = max_tfr;
> +	}
> +
> +	ssz = sz >> 9;
> +	dev_addr = mmc_test_capacity(test->card) / 4;
> +	if (tot_sz > dev_addr << 9)
> +		tot_sz = dev_addr << 9;
> +	cnt = tot_sz / sz;
> +	dev_addr &= 0xffff0000; /* Round to 64MiB boundary */
> +
> +	getnstimeofday(&ts1);
> +	for (i = 0; i < cnt; i++) {
> +		ret = mmc_test_area_io(test, sz, dev_addr, write,
> +				       max_scatter, 0);
> +		if (ret)
> +			return ret;
> +		dev_addr += ssz;
> +	}
> +	getnstimeofday(&ts2);
> +
> +	ts = timespec_sub(ts2, ts1);
> +	mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
> +
> +	return 0;
> +}
> +
> +static int mmc_test_large_seq_perf(struct mmc_test_card *test, int
write)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < 10; i++) {
> +		ret = mmc_test_seq_perf(test, write, 10 * 1024 * 1024, 1);
> +		if (ret)
> +			return ret;
> +	}
> +	for (i = 0; i < 5; i++) {
> +		ret = mmc_test_seq_perf(test, write, 100 * 1024 * 1024,
1);
> +		if (ret)
> +			return ret;
> +	}
> +	for (i = 0; i < 3; i++) {
> +		ret = mmc_test_seq_perf(test, write, 1000 * 1024 * 1024,
1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Large sequential read performance.
> + */
> +static int mmc_test_large_seq_read_perf(struct mmc_test_card *test)
> +{
> +	return mmc_test_large_seq_perf(test, 0);
> +}
> +
> +/*
> + * Large sequential write performance.
> + */
> +static int mmc_test_large_seq_write_perf(struct mmc_test_card *test)
> +{
> +	return mmc_test_large_seq_perf(test, 1);
> +}
> +
>  static const struct mmc_test_case mmc_test_cases[] = {
>  	{
>  		.name = "Basic write (no data verification)",
> @@ -2124,6 +2210,20 @@ static const struct mmc_test_case
mmc_test_cases[] = {
>  		.cleanup = mmc_test_area_cleanup,
>  	},
>
> +	{
> +		.name = "Large sequential read into scattered pages",
> +		.prepare = mmc_test_area_prepare,
> +		.run = mmc_test_large_seq_read_perf,
> +		.cleanup = mmc_test_area_cleanup,
> +	},
> +
> +	{
> +		.name = "Large sequential write from scattered pages",
> +		.prepare = mmc_test_area_prepare,
> +		.run = mmc_test_large_seq_write_perf,
> +		.cleanup = mmc_test_area_cleanup,
> +	},
> +
>  };
>
>  static DEFINE_MUTEX(mmc_test_lock);
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
