Return-Path: <SRS0=kaON=5I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D76C4332E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Mar 2020 18:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4E620637
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Mar 2020 18:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SbC7Ih2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgCWStk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:49:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44584 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgCWStk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2020 14:49:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so6280979plr.11
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2020 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1J62+9HfSlkv3NzIyJlYav7hvhHpbiduAqAYuKWJ56w=;
        b=SbC7Ih2DUxaxGl2gtNtmOwhFbplBnLc5bk/mh3cXsvp7HOWf+H6thuWp7k6GV4SFWl
         2bwkKMHcatMt3EMca3epfVROO0kjMJbZB2a4ZlHPLcwGDPucKlLBUqS/Wler1sMSZxb6
         VVVdlakmG4lbqpwioWnimupGTuHz3Rjf+T2TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1J62+9HfSlkv3NzIyJlYav7hvhHpbiduAqAYuKWJ56w=;
        b=szlvSibL0mDGre9ovEp/VvLVwZNoQYq67GvEpHVgrx39yDr9SBqcHymVf0nvVVGMWp
         eFxd3PbFkBHxXrWMmS00qzVvjZpOsPkpo2+yo4fL36QS88sdIPUqaIyif34KfMJNBIm9
         BScSTN5tIjKLe7M7qsJpO3zHdSVGOhnEt3+HIJSxwdHX6X3Lqi7Vqw4v9F8aLps5Rc1b
         X79uMYIA6YVh7mAdYUFGMhDjDmom2f41uYO/S00rIbq6xneUXLh31b0aL7gal9zy1YcI
         shFk4v+xnWkpQt8fsT6pxw7IHR5yWJ4+KhKsAG91ibDNJyWkCjZhCMoOfYoPR424HL5x
         ew/A==
X-Gm-Message-State: ANhLgQ0CeUnib0wkqRbs20GnRwlMZKGNxbZrjOYaPCckYIf2TKASVUPi
        S3hRGeMjMJhEtuz7FGLE/3UTfw==
X-Google-Smtp-Source: ADFU+vvpjGAyHWqVVPVwL5kdxCIfYTBil33Sbc1RfBQNKWThdNuKFWbzHLc86aIi9iNWcwJvnb1FIw==
X-Received: by 2002:a17:90b:4d04:: with SMTP id mw4mr821413pjb.180.1584989378516;
        Mon, 23 Mar 2020 11:49:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id i11sm281182pje.30.2020.03.23.11.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:49:37 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:49:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
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
Subject: Re: [RFC v6 1/2] mmc: sdhci-msm: Add interconnect bus bandwidth
 scaling support
Message-ID: <20200323184936.GC204494@google.com>
References: <1584973502-14775-1-git-send-email-ppvk@codeaurora.org>
 <1584973502-14775-2-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1584973502-14775-2-git-send-email-ppvk@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Pradeep,

On Mon, Mar 23, 2020 at 07:55:01PM +0530, Pradeep P V K wrote:
> Add interconnect bandwidths for SDHC driver using OPP framework that
> is required by SDHC driver based on the clock frequency and bus width
> of the card. Otherwise, the system clocks may run at minimum clock
> speed and thus affecting the performance.
> 
> This change is based on
> [RFC] mmc: host: sdhci-msm: Use the interconnect API
> (https://lkml.org/lkml/2018/10/11/499) and
> 
> [PATCH v6] Introduce Bandwidth OPPs for interconnects
> (https://lkml.org/lkml/2019/12/6/740)
> 
> Co-developed-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Co-developed-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Co-developed-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Co-developed-by: Pradeep P V K <ppvk@codeaurora.org>
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
> 
> RFC v5 -> v6:
> - Added new goto jump tag to put both icc paths.
> - Removed bus vote data error check and added is_null check.
> - Addressed minor code style comments.
> 
>  drivers/mmc/host/sdhci-msm.c | 240 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 236 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 09ff731..469db65 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
>
> ...
>
> +/*
> + * Helper function to parse the exact OPP node
> + * Returns OPP pointer on success else NULL on error
> + */
> +static struct dev_pm_opp
> +		*sdhci_msm_find_opp_for_freq(struct sdhci_msm_host *msm_host,
> +							unsigned long bw)
> +{
> +	struct dev_pm_opp *opp;
> +	struct sdhci_host *host = mmc_priv(msm_host->mmc);
> +	unsigned int freq = bw;
> +	struct device *dev = &msm_host->pdev->dev;
> +
> +

delete one empty line

> +	if (!freq)
> +		opp = dev_pm_opp_find_peak_bw_floor(dev, &freq);
> +	else
> +		opp = dev_pm_opp_find_peak_bw_exact(dev, freq, true);
> +
> +	/* Max bandwidth vote */
> +	if (PTR_ERR(opp) == -ERANGE && freq > sdhci_msm_get_max_clock(host))
> +		opp = dev_pm_opp_find_peak_bw_ceil(dev, &bw);
> +
> +	if (IS_ERR(opp)) {
> +		dev_err(dev, "Failed to find OPP for freq:%u err:%ld\n",
> +				freq, PTR_ERR(opp));
> +		return NULL;
> +	}
> +	return opp;
> +}
>
> ...
>
> +/*
> + * Helper function to register for OPP and interconnect
> + * frameworks.
> + */
> +static struct sdhci_msm_bus_vote_data
> +		*sdhci_msm_bus_register(struct sdhci_msm_host *host,
> +				struct platform_device *pdev)
> +{
> +	struct sdhci_msm_bus_vote_data *vote_data;
> +	struct device *dev = &pdev->dev;
> +	int i, err;
> +	struct icc_path *icc_paths[BUS_INTERCONNECT_PATHS];
> +	const char *path_names[] = {
> +		"sdhc-ddr",
> +		"cpu-sdhc",
> +	};
> +
> +	for (i = 0; i < BUS_INTERCONNECT_PATHS; i++)
> +		icc_paths[i] = of_icc_get(&pdev->dev, path_names[i]);
> +
> +	if (!icc_paths[0] && !icc_paths[1]) {
> +		dev_info(&pdev->dev, "ICC DT property is missing.Skip vote!!\n");
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < BUS_INTERCONNECT_PATHS; i++) {
> +		if (!icc_paths[i]) {
> +			dev_err(&pdev->dev, "interconnect path '%s' is not configured\n",
> +					path_names[i]);
> +			err = -EINVAL;
> +			goto handle_err;
> +		}
> +		if (IS_ERR(icc_paths[i])) {
> +			err = PTR_ERR(icc_paths[i]);
> +
> +			if (err != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "interconnect path '%s' is invalid:%d\n",
> +					path_names[i], err);
> +			goto handle_err;
> +		}
> +	}
> +
> +	err = dev_pm_opp_of_add_table(dev);
> +	if (err) {
> +		if (err == -ENODEV || err == -ENODATA)
> +			dev_err(dev, "OPP dt properties missing:%d\n", err);
> +		else
> +			dev_err(dev, "OPP registration failed:%d\n", err);
> +		goto put_icc;
> +	}
> +
> +	vote_data = devm_kzalloc(dev, sizeof(*vote_data), GFP_KERNEL);
> +	if (!vote_data) {
> +		err = -ENOMEM;
> +		goto put_icc;
> +	}
> +	vote_data->sdhc_to_ddr = icc_paths[0];
> +	vote_data->cpu_to_sdhc = icc_paths[1];
> +	return vote_data;
> +
> +handle_err:
> +	if (err) {

the check for 'err' is not needed, this code is only executed when an error
is encountered.

> +		int other = (i == 0) ? 1 : 0;
> +
> +		if (!IS_ERR_OR_NULL(icc_paths[other]))
> +			icc_put(icc_paths[other]);
> +	}
> +	return ERR_PTR(err);
> +
> +put_icc:
> +	if (err) {
> +		for (i = 0; i < BUS_INTERCONNECT_PATHS; i++)
> +			icc_put(icc_paths[i]);
> +	}
> +	return ERR_PTR(err);

The two error paths are somewhat redundant and the 'handle_err' isn't super
clear, especially since it is disconnected from the code where the error is
found.

You could have a single handler instead:

put_icc:
	for (i = 0; i < BUS_INTERCONNECT_PATHS; i++) {
		if (!IS_ERR_OR_NULL(icc_paths[i]))
			icc_put(icc_paths[i]);
        }

	return ERR_PTR(err);
