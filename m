Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85C156E7
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jan 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+m81wqI"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f07f9d57b9so22331527b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jan 2024 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704214660; x=1704819460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3auKv/7swBxkp6/ff5ck5tK1RE4qnX0SjBfpKt4+hg=;
        b=I+m81wqIHh1825lLbBTbUVupJXcJvxR4VQG7OEjrxK/3hF74acDC69shB3ctVjePf3
         DTRas3Non4ki8xTDYN4UvXwO5kQQtmFYNlHTC45xndHjnlyImFTQvsPn6GohNN7IRQEH
         OpCxpea4/1shlMifKRF9hoeyu0WJGa5DDukDglds1waSKqiFNR6UeCIFjaEULCKVM5nh
         m0UrErZ2IxndQnAl2FGr+f8qn2AdweFTrv6Wa30Upk6n1MKi2BslKcaHJvXJqVTS2o9/
         XRbDBNHqSTNeEFe6rMXjw+1OAu+awl8F1k8TMsfscx3JuXxaVGYM4JDTZYSI4zBcnxav
         iuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214660; x=1704819460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3auKv/7swBxkp6/ff5ck5tK1RE4qnX0SjBfpKt4+hg=;
        b=gf4XZjKlYSKbj0JQBcrNj3N9u6ISotl7pQ88LLKxhKYDCdKU2ip7BBeYAUtvYh6ybL
         KucVOsy/zyxgMcU6tWBpoOD1B+uXuvoW7LKDG3/OTvhuKuBZQr82orQW4gNj7dMewyhO
         jV/vR8FBfJZs3169WtF/9xTchBoQTW8iZvP1dwNWhcxQpu634qb8Myj84BYZeK6Q50GW
         sD45efAbMWhhtWl7fa6lUGl9j3UXRbHggt0uoMwb3CauUjnBF+cSm/xCEj2XO8PnjtPG
         sAvIM+jaxSyjsHrwd4LxwtE+QMzg8u3KNW0mIjOupp9G5waS/9y40t1ubfSu4vGVOS7/
         WKQg==
X-Gm-Message-State: AOJu0YwLYK0rnnTOwga1jUtsfuyROvLmJivTZuUPzCA0tDsSNg4jI+0b
	D3eeS5nCrWBInBFFbl0HS23NdQx3FB+k8EGaMGSrTKmjsSpW5A==
X-Google-Smtp-Source: AGHT+IGAoVQ5UQeH48P01G1v43C+Ky9bA6NPlfy2ewALqP4qliuCD7m9RdvdkniAc+WD274nZ9LgummS+3K0rK2Soc8=
X-Received: by 2002:a0d:f301:0:b0:5e8:a3c1:33c6 with SMTP id
 c1-20020a0df301000000b005e8a3c133c6mr10697462ywf.104.1704214660534; Tue, 02
 Jan 2024 08:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214090902.43628-1-adrian.hunter@intel.com>
In-Reply-To: <20231214090902.43628-1-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Jan 2024 17:57:04 +0100
Message-ID: <CAPDyKFrqn8HDuUzeN+Wt7NYKgVy_TieSMRzE4C0+1DoDE18BKw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: Add re-tuning test
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: jorge@foundries.io, avri.altman@wdc.com, christian.loehle@arm.com, 
	ricardo@foundries.io, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 10:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add a test to repeatedly re-tune in between random reads.  The test is
> non-destructive of data on the card and runs for 30 seconds.  The test
> can be repeated to test for longer durations.
>
> If re-tuning is not supported, the test is skipped.
>
> Example:
>
>   # echo 'mmc1:0001' >  /sys/bus/mmc/drivers/mmcblk/unbind
>   # echo 'mmc1:0001' > /sys/bus/mmc/drivers/mmc_test/bind
>   [   36.642257] mmc_test mmc1:0001: Card claimed for testing.
>   # cat /sys/kernel/debug/mmc1/mmc1\:0001/testlist | grep tuning
>   52:     Re-tuning reliability
>   # echo 52 > /sys/kernel/debug/mmc1/mmc1\:0001/test
>   [   91.522555] mmc1: Starting tests of card mmc1:0001...
>   [   91.528425] mmc1: Test case 52. Re-tuning reliability...
>   [  121.536682] mmc1: Result: OK
>   [  121.539572] mmc1: Tests completed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_test.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 0f6a563103fd..8f7f587a0025 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -1904,7 +1904,7 @@ static unsigned int mmc_test_rnd_num(unsigned int rnd_cnt)
>  }
>
>  static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
> -                            unsigned long sz)
> +                            unsigned long sz, int secs, int force_retuning)
>  {
>         unsigned int dev_addr, cnt, rnd_addr, range1, range2, last_ea = 0, ea;
>         unsigned int ssz;
> @@ -1921,7 +1921,7 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
>         for (cnt = 0; cnt < UINT_MAX; cnt++) {
>                 ktime_get_ts64(&ts2);
>                 ts = timespec64_sub(ts2, ts1);
> -               if (ts.tv_sec >= 10)
> +               if (ts.tv_sec >= secs)
>                         break;
>                 ea = mmc_test_rnd_num(range1);
>                 if (ea == last_ea)
> @@ -1929,6 +1929,8 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
>                 last_ea = ea;
>                 dev_addr = rnd_addr + test->card->pref_erase * ea +
>                            ssz * mmc_test_rnd_num(range2);
> +               if (force_retuning)
> +                       mmc_retune_needed(test->card->host);
>                 ret = mmc_test_area_io(test, sz, dev_addr, write, 0, 0);
>                 if (ret)
>                         return ret;
> @@ -1953,24 +1955,35 @@ static int mmc_test_random_perf(struct mmc_test_card *test, int write)
>                  */
>                 if (write) {
>                         next = rnd_next;
> -                       ret = mmc_test_rnd_perf(test, write, 0, sz);
> +                       ret = mmc_test_rnd_perf(test, write, 0, sz, 10, 0);
>                         if (ret)
>                                 return ret;
>                         rnd_next = next;
>                 }
> -               ret = mmc_test_rnd_perf(test, write, 1, sz);
> +               ret = mmc_test_rnd_perf(test, write, 1, sz, 10, 0);
>                 if (ret)
>                         return ret;
>         }
>         sz = t->max_tfr;
>         if (write) {
>                 next = rnd_next;
> -               ret = mmc_test_rnd_perf(test, write, 0, sz);
> +               ret = mmc_test_rnd_perf(test, write, 0, sz, 10, 0);
>                 if (ret)
>                         return ret;
>                 rnd_next = next;
>         }
> -       return mmc_test_rnd_perf(test, write, 1, sz);
> +       return mmc_test_rnd_perf(test, write, 1, sz, 10, 0);
> +}
> +
> +static int mmc_test_retuning(struct mmc_test_card *test)
> +{
> +       if (!mmc_can_retune(test->card->host)) {
> +               pr_info("%s: No retuning - test skipped\n",
> +                       mmc_hostname(test->card->host));
> +               return RESULT_UNSUP_HOST;
> +       }
> +
> +       return mmc_test_rnd_perf(test, 0, 0, 8192, 30, 1);
>  }
>
>  /*
> @@ -2921,6 +2934,14 @@ static const struct mmc_test_case mmc_test_cases[] = {
>                 .run = mmc_test_cmds_during_write_cmd23_nonblock,
>                 .cleanup = mmc_test_area_cleanup,
>         },
> +
> +       {
> +               .name = "Re-tuning reliability",
> +               .prepare = mmc_test_area_prepare,
> +               .run = mmc_test_retuning,
> +               .cleanup = mmc_test_area_cleanup,
> +       },
> +
>  };
>
>  static DEFINE_MUTEX(mmc_test_lock);
> --
> 2.34.1
>
