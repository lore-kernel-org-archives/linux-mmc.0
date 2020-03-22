Return-Path: <SRS0=THLs=5H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64624C4332B
	for <linux-mmc@archiver.kernel.org>; Sun, 22 Mar 2020 16:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E6120724
	for <linux-mmc@archiver.kernel.org>; Sun, 22 Mar 2020 16:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PjMhD9Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgCVQCA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:02:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13143 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgCVQCA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Mar 2020 12:02:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584892919; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=KbW1c1jJh3fjm7VZhx+zDnxPu5lMEAB+5FN/4TFQHC0=;
 b=PjMhD9FzPBRbNy20LaNNizeKvYSEdZNuVV9rT4/jRxWi5dG0cAiDI/+Pmo3QDhuaxdJxxTqe
 ORAo6Ko9RMQS9sihqiuCjY2KAQyvYj+1rA/P8XWOipovqJpAgOZqGyALT9ltTiJxjRve6qn5
 pQ4dELRBa5V0q0YiPZ9gpSULMYw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e778bf7.7feaa835a420-smtp-out-n01;
 Sun, 22 Mar 2020 16:01:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E19ECC43637; Sun, 22 Mar 2020 16:01:58 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4AA8C433CB;
        Sun, 22 Mar 2020 16:01:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 22 Mar 2020 21:31:57 +0530
From:   ppvk@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, rampraka@codeaurora.org,
        vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-mmc-owner@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [RFC v5 1/2] mmc: sdhci-msm: Add interconnect bus bandwidth
 scaling support
In-Reply-To: <20200312204935.GF144492@google.com>
References: <1583992911-12001-1-git-send-email-ppvk@codeaurora.org>
 <1583992911-12001-2-git-send-email-ppvk@codeaurora.org>
 <20200312204935.GF144492@google.com>
Message-ID: <11a193adc32906f28358556dfc11858c@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2020-03-13 02:19, Matthias Kaehlcke wrote:
Hi Matthias,

Thanks for reviewing.

> Hi Pradeep,
> 
> On Thu, Mar 12, 2020 at 11:31:50AM +0530, Pradeep P V K wrote:
>> Add interconnect bandwidths for SDHC driver using OPP framework that
>> is required by SDHC driver based on the clock frequency and bus width
>> of the card. Otherwise, the system clocks may run at minimum clock
>> speed and thus affecting the performance.
>> 
>> This change is based on
>> [RFC] mmc: host: sdhci-msm: Use the interconnect API
>> (https://lkml.org/lkml/2018/10/11/499) and
>> 
>> [PATCH v6] Introduce Bandwidth OPPs for interconnects
>> (https://lkml.org/lkml/2019/12/6/740)
>> 
>> Co-developed-by: Sahitya Tummala <stummala@codeaurora.org>
>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>> Co-developed-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Co-developed-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> Co-developed-by: Pradeep P V K <ppvk@codeaurora.org>
>> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
>> ---
>> 
>> RFC v4 -> v5:
>> - Rewrote the icc interconnect get handlers and its error handling
>>   and allocated vote data after handling all icc get handler errors.
>> - Removed explicit error check on ICC handlers.
>> - Addressed minor code style comments.
>> 
>>  drivers/mmc/host/sdhci-msm.c | 231 
>> ++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 227 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci-msm.c 
>> b/drivers/mmc/host/sdhci-msm.c
>> index 09ff731..5fe8fad 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> 
>> ...
>> 
>> +/*
>> + * This function sets the interconnect bus bandwidth
>> + * vote based on bw (bandwidth) argument.
>> + */
>> +#define BUS_INTERCONNECT_PATHS 2 /* 1. sdhc -> ddr 2. cpu -> sdhc */
>> +static void sdhci_msm_bus_set_vote(struct sdhci_host *host,
>> +						unsigned int bw)
>> +{
>> +	int i, err;
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +	struct sdhci_msm_bus_vote_data *vote_data = msm_host->bus_vote_data;
>> +	struct device *dev = &msm_host->pdev->dev;
>> +	struct dev_pm_opp *opp;
>> +	unsigned long freq = bw;
>> +	unsigned long peak_bw[BUS_INTERCONNECT_PATHS] = {0};
>> +	unsigned long avg_bw[BUS_INTERCONNECT_PATHS] = {0};
>> +
>> +	if (bw == vote_data->curr_freq)
>> +		return;
>> +
>> +	for (i = 0; i < BUS_INTERCONNECT_PATHS; i++) {
>> +		opp = sdhci_msm_find_opp_for_freq(msm_host, freq);
>> +		if (opp) {
>> +			avg_bw[i] = dev_pm_opp_get_bw(opp, &peak_bw[i]);
>> +			freq += 1; /* Next bandwidth vote */
>> +			dev_pm_opp_put(opp);
>> +		}
>> +	}
>> +	pr_debug("%s: freq:%d sdhc_to_ddr avg_bw:%lu peak_bw:%lu cpu_to_sdhc 
>> avg_bw:%lu peak_bw:%lu\n",
>> +			mmc_hostname(host->mmc), bw, avg_bw[0], peak_bw[0],
>> +				avg_bw[1], peak_bw[1]);
>> +	err = icc_set_bw(vote_data->sdhc_to_ddr, 0, peak_bw[0]);
>> +	if (err) {
>> +		dev_err(dev, "icc_set() failed for 'sdhc-ddr' path err:%d\n",
>> +							err);
> 
> nit: the alignment is odd, either align with 'dev' or a tab after 
> 'dev_err'
> 
sure, will do this in my next patch set.
>> +		return;
>> +	}
>> +	err = icc_set_bw(vote_data->cpu_to_sdhc, 0, peak_bw[1]);
>> +	if (err) {
>> +		dev_err(dev, "icc_set() failed for 'cpu-sdhc' path err:%d\n",
>> +							err);
> 
> ditto
> 
ok.

>> +		return;
>> +	}
>> +	vote_data->curr_freq = bw;
>> +}
>> +
>> +/*
>> + * Helper function to register for OPP and interconnect
>> + * frameworks.
>> + */
>> +static struct sdhci_msm_bus_vote_data
>> +		*sdhci_msm_bus_register(struct sdhci_msm_host *host,
>> +				struct platform_device *pdev)
>> +{
>> +	struct sdhci_msm_bus_vote_data *vote_data;
>> +	struct device *dev = &pdev->dev;
>> +	int ret, i, err;
> 
> nit: you can get rid of 'ret' and use 'err' instead.
> 
ok. i will do this in my next patchset.

>> +	struct icc_path *icc_paths[BUS_INTERCONNECT_PATHS];
>> +	const char *path_names[] = {
>> +		"sdhc-ddr",
>> +		"cpu-sdhc",
>> +	};
>> +
>> +	for (i = 0; i < BUS_INTERCONNECT_PATHS; i++)
>> +		icc_paths[i] = of_icc_get(&pdev->dev, path_names[i]);
>> +
>> +	if (!icc_paths[0] && !icc_paths[1]) {
>> +		dev_info(&pdev->dev, "ICC DT property is missing.Skip vote!!\n");
>> +		return NULL;
>> +	}
>> +
>> +	for (i = 0; i < BUS_INTERCONNECT_PATHS; i++) {
>> +		if (!icc_paths[i]) {
>> +			dev_err(&pdev->dev, "interconnect path '%s' is not configured\n",
>> +					path_names[i]);
>> +			err = -EINVAL;
>> +			goto handle_err;
>> +		}
>> +		if (IS_ERR(icc_paths[i])) {
>> +			err = PTR_ERR(icc_paths[i]);
>> +
>> +			if (err != -EPROBE_DEFER)
>> +				dev_err(&pdev->dev, "interconnect path '%s' is invalid:%d\n",
>> +					path_names[i], err);
>> +			goto handle_err;
>> +		}
>> +	}
>> +
>> +	ret = dev_pm_opp_of_add_table(dev);
>> +	if (ret) {
>> +		if (ret == -ENODEV || ret == -ENODATA)
>> +			dev_err(dev, "OPP dt properties missing:%d\n", ret);
>> +		else
>> +			dev_err(dev, "OPP registration failed:%d\n", ret);
> 
> need to call icc_put() for the two paths?
> 
hmm yes. coming here means, we got both icc paths without error.
So, should put both icc paths. I will handle this by adding a new goto 
jump tag.

>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	vote_data = devm_kzalloc(dev, sizeof(*vote_data), GFP_KERNEL);
>> +	if (!vote_data)
> 
> ditto
> 
> probably you want to do this with a jump to an error handler below.
> 
ok. i will handle this by adding a new goto jump tag.

>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	vote_data->sdhc_to_ddr = icc_paths[0];
>> +	vote_data->cpu_to_sdhc = icc_paths[1];
>> +	return vote_data;
> 
> nit: add empty line
> 
ok.

>> +handle_err:
>> +	if (err) {
>> +		int other = (i == 0) ? 1 : 0;
>> +
>> +		if (!IS_ERR_OR_NULL(icc_paths[other]))
>> +			icc_put(icc_paths[other]);
>> +	}
> 
> doing this at the end (as opposed to my suggestion from
> https://patchwork.kernel.org/patch/11388409/#23165321) has the 
> advantage of
> keeping the above loop cleaner from error handling cruft, on the 
> downside it
> is probably easier to understand right away in the context of the loop. 
> I
> guess you can do it either way.
> 
True. i will leave this error handling at bottom as the code looks more 
cleaner.

> It might get a bit more messy if you also handle the case where both 
> paths are
> valid. If that gets too involved I'd suggest to hnadle the above case 
> inside
> the loop.
> 
hmm true, handling the above error in loop making the code more messy 
so,
i'm using a new tag (put_icc) to put both the icc paths.

>> +	return ERR_PTR(err);
>> +}
>> +
>> +static void sdhci_msm_bus_unregister(struct device *dev,
>> +				struct sdhci_msm_host *host)
>> +{
>> +	struct sdhci_msm_bus_vote_data *vote_data = host->bus_vote_data;
>> +
>> +	if (IS_ERR_OR_NULL(vote_data))
> 
> I think 'if (!vote_data)' would be sufficient, since _probe() aborts in
> case of an error.
> 
ok. i will handle this in my next patch set.

>> +		return;
>> +
>> +	icc_put(vote_data->sdhc_to_ddr);
>> +	icc_put(vote_data->cpu_to_sdhc);
>> +}
>> +
>> +static void sdhci_msm_bus_voting(struct sdhci_host *host, bool 
>> enable)
>> +{
>> +	struct mmc_ios *ios = &host->mmc->ios;
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +	unsigned int bw;
>> +
>> +	if (IS_ERR_OR_NULL(msm_host->bus_vote_data))
>> +		return;
> 
> ditto
ok.
