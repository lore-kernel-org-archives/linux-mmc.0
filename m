From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: mmc-test: y2038, use boottime to compare time
Date: Mon, 01 Feb 2016 20:45:48 +0100
Message-ID: <5473957.GNRnMugOEa@wuerfel>
References: <1454298188-17174-1-git-send-email-klock.android@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63664 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbcBATpv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 14:45:51 -0500
In-Reply-To: <1454298188-17174-1-git-send-email-klock.android@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Abhilash Jindal <klock.android@gmail.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

On Sunday 31 January 2016 22:43:08 Abhilash Jindal wrote:
> Wall time obtained from getnstimeofday gives 32 bit timeval which can only
> represent time until January 2038. This patch moves to ktime_t, a 64-bit time.
> 
> Also, wall time is susceptible to sudden jumps due to user setting the time or
> due to NTP.  Boot time is constantly increasing time better suited for
> subtracting two timestamps.
> 
> Signed-off-by: Abhilash Jindal <klock.android@gmail.com>

Everything looks correct to me, nice work!

I have a few comments to make the approach consistent with what we have
been doing with other drivers:

Using boottime sounds like a correct approach, but I wonder whether
we should just use monotonic time instead, as we do for most conversions.

>  static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
> -				    unsigned int count, struct timespec *ts1,
> -				    struct timespec *ts2)
> +				    unsigned int count, ktime_t tm1,
> +				    ktime_t tm2)
>  {
>  	unsigned int rate, iops, sectors = bytes >> 9;
>  	uint64_t tot = bytes * count;
> -	struct timespec ts;
> -
> -	ts = timespec_sub(*ts2, *ts1);
> +	ktime_t tm = ktime_sub(tm2, tm1);
> +	struct timespec ts = ktime_to_timespec(tm);

Please use timespec64 here, otherwise we have to come back to the driver
again to change that when we remove 'struct timespec'.

> -	rate = mmc_test_rate(tot, &ts);
> -	iops = mmc_test_rate(count * 100, &ts); /* I/O ops per sec x 100 */
> +	rate = mmc_test_rate(tot, tm);
> +	iops = mmc_test_rate(count * 100, tm); /* I/O ops per sec x 100 */
>  
>  	pr_info("%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
>  			 "%lu.%09lu seconds (%u kB/s, %u KiB/s, "

When you do that, please be aware that you have to use a type cast here
and print the tv_sec portion using either %lu or %llu, with the matching
cast: 64-bit systems use 'long tv_sec' and 32-bit systems use 'long long
tv_sec' here for obscure reasons.

> @@ -1854,7 +1848,8 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
>  {
>  	unsigned int dev_addr, cnt, rnd_addr, range1, range2, last_ea = 0, ea;
>  	unsigned int ssz;
> -	struct timespec ts1, ts2, ts;
> +	ktime_t tm1, tm2, tm;
> +	struct timespec ts;
>  	int ret;
>  
>  	ssz = sz >> 9;

Same here.

> @@ -1863,10 +1858,11 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
>  	range1 = rnd_addr / test->card->pref_erase;
>  	range2 = range1 / ssz;
>  
> -	getnstimeofday(&ts1);
> +	tm1 = ktime_get_boottime();
>  	for (cnt = 0; cnt < UINT_MAX; cnt++) {
> -		getnstimeofday(&ts2);
> -		ts = timespec_sub(ts2, ts1);
> +		tm2 = ktime_get_boottime();
> +		tm = ktime_sub(tm2, tm1);
> +		ts = ktime_to_timespec(tm);
>  		if (ts.tv_sec >= 10)

Alternatively, you could do

		if (ktime_to_ns(tm) >= 10 * NSEC_PER_SEC)

	Arnd
