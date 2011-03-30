From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: RE: [PATCH 2/3] mmc_test: add tests to measure random I/O operations
 per second
Date: Wed, 30 Mar 2011 16:26:47 +0530
Message-ID: <865ef66d8a88ca9b864c7062dcc04dfc@mail.gmail.com>
References: <1297165263-656-1-git-send-email-adrian.hunter@nokia.com> <1297165263-656-3-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48550 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754193Ab1C3K44 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 06:56:56 -0400
Received: by mail-bw0-f41.google.com with SMTP id 17so865495bwz.28
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 03:56:55 -0700 (PDT)
In-Reply-To: <1297165263-656-3-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>

> +
> +static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int
print,
> +			     unsigned long sz)
> +{
> +	unsigned int dev_addr, cnt, rnd_addr, range1, range2, last_ea = 0,
ea;
> +	unsigned int ssz;
> +	struct timespec ts1, ts2, ts;
> +	int ret;
> +

Tabify all you declarations here.

> +	ssz = sz >> 9;
> +
> +	rnd_addr = mmc_test_capacity(test->card) / 4;
> +	range1 = rnd_addr / test->card->pref_erase;
> +	range2 = range1 / ssz;
> +
> +	getnstimeofday(&ts1);
> +	for (cnt = 0; cnt < UINT_MAX; cnt++) {
> +		getnstimeofday(&ts2);
> +		ts = timespec_sub(ts2, ts1);
> +		if (ts.tv_sec >= 10)
> +			break;
> +		ea = mmc_test_rnd_num(range1);
> +		if (ea == last_ea)
> +			ea -= 1;
> +		last_ea = ea;
> +		dev_addr = rnd_addr + test->card->pref_erase * ea +
> +			   ssz * mmc_test_rnd_num(range2);
> +		ret = mmc_test_area_io(test, sz, dev_addr, write, 0, 0);
> +		if (ret)
> +			return ret;
> +	}
> +	if (print)
> +		mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
> +	return 0;
> +}
> +
> +static int mmc_test_random_perf(struct mmc_test_card *test, int write)
> +{
> +	unsigned int next;
> +	unsigned long sz;
> +	int ret;
> +
> +	for (sz = 512; sz < test->area.max_tfr; sz <<= 1) {
> +		/*
> +		 * When writing, try to get more consistent results by
running
> +		 * the test twice with exactly the same I/O but outputting
the
> +		 * results only for the 2nd run.
> +		 */
> +		if (write) {
> +			next = rnd_next;
> +			ret = mmc_test_rnd_perf(test, write, 0, sz);
> +			if (ret)
> +				return ret;
> +			rnd_next = next;
> +		}
> +		ret = mmc_test_rnd_perf(test, write, 1, sz);
> +		if (ret)
> +			return ret;
> +	}
> +	sz = test->area.max_tfr;
> +	if (write) {
> +		next = rnd_next;
> +		ret = mmc_test_rnd_perf(test, write, 0, sz);
> +		if (ret)
> +			return ret;
> +		rnd_next = next;
> +	}
> +	return mmc_test_rnd_perf(test, write, 1, sz);
> +}
> +
> +/*
> + * Random read performance by transfer size.
> + */
> +static int mmc_test_random_read_perf(struct mmc_test_card *test)
> +{
> +	return mmc_test_random_perf(test, 0);
> +}
> +
> +/*
> + * Random write performance by transfer size.
> + */
> +static int mmc_test_random_write_perf(struct mmc_test_card *test)
> +{
> +	return mmc_test_random_perf(test, 1);
> +}
> +
>  static const struct mmc_test_case mmc_test_cases[] = {
>  	{
>  		.name = "Basic write (no data verification)",
> @@ -2007,6 +2110,20 @@ static const struct mmc_test_case
mmc_test_cases[] = {
>  		.cleanup = mmc_test_area_cleanup,
>  	},
>
> +	{
> +		.name = "Random read performance by transfer size",
> +		.prepare = mmc_test_area_prepare,
> +		.run = mmc_test_random_read_perf,
> +		.cleanup = mmc_test_area_cleanup,
> +	},
> +
> +	{
> +		.name = "Random write performance by transfer size",
> +		.prepare = mmc_test_area_prepare,
> +		.run = mmc_test_random_write_perf,
> +		.cleanup = mmc_test_area_cleanup,
> +	},
> +
>  };
>
>  static DEFINE_MUTEX(mmc_test_lock);
> @@ -2150,11 +2267,11 @@ static int mtf_test_show(struct seq_file *sf,
void *data)
>  		seq_printf(sf, "Test %d: %d\n", gr->testcase + 1,
gr->result);
>
>  		list_for_each_entry(tr, &gr->tr_lst, link) {
> -			seq_printf(sf, "%u %d %lu.%09lu %u\n",
> +			seq_printf(sf, "%u %d %lu.%09lu %u %u.%02u\n",
>  				tr->count, tr->sectors,
>  				(unsigned long)tr->ts.tv_sec,
>  				(unsigned long)tr->ts.tv_nsec,
> -				tr->rate);
> +				tr->rate, tr->iops / 100, tr->iops % 100);
>  		}
>  	}
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
