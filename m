Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596FEC43381
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Jan 2021 07:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399D22087E
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Jan 2021 07:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhADHQQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Jan 2021 02:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbhADHQP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jan 2021 02:16:15 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5F6C061795
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jan 2021 23:15:35 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 11so15929147pfu.4
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jan 2021 23:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5qtGC03cGR6fBZ/P7WwG5L1MqF0Nj6bOUHj8Uj+kHE=;
        b=OAaqSR5s9Ik5xFghIWI9hC6wEO4akfqQjR1AOd5DY6Xi6Mevb8NLfqSZDyR+1BWPVQ
         0nbaAvHDIACvQtTkVUUyk4W1NyB8M+CTEIC4YreClD/ms9PJv6vmduZftbG4+VxGdOh4
         M2KFQBwKG84Zx7cCdRv4veEdNPZJFPANKBuC2fDoeERuVv3Scp7X7O8hMrqZZS6srLBv
         4klE090qhDFDneRddwMkgzplBW/qRn/Ef8pTZMWvv0IWo+yNujZjEzfyoQ9ES/u+JKZk
         ZoZvpTEodAuDAUMYxGd05rAyu5Bd5sJ6rfBLxqikk+xkarbqtpsvSayBj5tVwYSPv/Z6
         emVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5qtGC03cGR6fBZ/P7WwG5L1MqF0Nj6bOUHj8Uj+kHE=;
        b=RYJMYOcPXQQJQ7guP6k2h/9y2HLursY6b1wP4I+JpEod2jHO6QtdL4gUDhLey/aLGl
         aJQ7HF/BoAWq5/x5aqXLtbkN2/I6XXLnfDoN0dGCc8SbHKuXGUh6LIodRRzRvpwyOluV
         wkicof5Ul8/9oyfZXNlV+KmfvnTpMEBHHOrH0AxXQKCZGcXAgLJChetPj73Bb43Ky7Cc
         OmqNoSWie5S8QzxrmT6UquFLrlTx1x/uzk5xQWdKNzaxbjvOuNZKPQVx5OPHwQ5SzVz0
         dUAf42wGB6slLQD6xqA4OvhRNsFlAne4gWRqBWV8Il/MCgMcDk7+GqTBpcLOfSUzLDKG
         zEeg==
X-Gm-Message-State: AOAM5303cfnLxAAFNM+ybxsry4fzp/cEHKQPSTgsfI/B7NVRzFuIF48h
        3r46M77JRnIndSeM/7evcSMRlQ==
X-Google-Smtp-Source: ABdhPJxGFwAV2SQtVU4VNuP02uvq/Pafhur3RgVz2v7E9ia11SPp2CuAR1+kuobkLcHSmIraN1mtOQ==
X-Received: by 2002:a65:4983:: with SMTP id r3mr71474424pgs.288.1609744534592;
        Sun, 03 Jan 2021 23:15:34 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id 22sm20354596pjw.19.2021.01.03.23.15.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:15:33 -0800 (PST)
Date:   Mon, 4 Jan 2021 12:45:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, digetx@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yuq825@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robdclark@gmail.com, sean@poorly.run,
        robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, stanimir.varbanov@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        lukasz.luba@arm.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, jonathan@marek.ca,
        akhilpo@codeaurora.org, smasetty@codeaurora.org,
        airlied@redhat.com, masneyb@onstation.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, ddavenport@chromium.org,
        jsanka@codeaurora.org, rnayak@codeaurora.org,
        tongtiangen@huawei.com, miaoqinglang@huawei.com,
        khsieh@codeaurora.org, abhinavk@codeaurora.org,
        chandanu@codeaurora.org, groeck@chromium.org, varar@codeaurora.org,
        mka@chromium.org, harigovi@codeaurora.org,
        rikard.falkeborn@gmail.com, natechancellor@gmail.com,
        georgi.djakov@linaro.org, akashast@codeaurora.org,
        parashar@codeaurora.org, dianders@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 05/31] opp: Add devres wrapper for
 dev_pm_opp_register_notifier
Message-ID: <20210104071531.oyc64zgfot43gupv@vireshk-i7>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-6-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-6-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01-01-21, 16:54, Yangtao Li wrote:
> Add devres wrapper for dev_pm_opp_register_notifier() to simplify driver
> code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/opp/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 6b83e373f0d8..ef3544f8cecd 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2599,6 +2599,44 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
>  }
>  EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
>  
> +static void devm_pm_opp_notifier_release(struct device *dev, void *res)
> +{
> +	struct notifier_block *nb = *(struct notifier_block **)res;
> +
> +	WARN_ON(dev_pm_opp_unregister_notifier(dev, nb));
> +}
> +
> +/**
> + * devm_pm_opp_register_notifier() - Register OPP notifier for the device
> + * @dev:	Device for which notifier needs to be registered
> + * @nb:		Notifier block to be registered
> + *
> + * Return: 0 on success or a negative error value.
> + *
> + * The notifier will be unregistered after the device is destroyed.
> + */
> +int devm_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
> +{
> +	struct notifier_block **ptr;
> +	int ret;
> +
> +	ptr = devres_alloc(devm_pm_opp_notifier_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret = dev_pm_opp_register_notifier(dev, nb);
> +	if (ret) {
> +		devres_free(ptr);
> +		return ret;
> +	}
> +
> +	*ptr = nb;
> +	devres_add(dev, ptr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(devm_pm_opp_register_notifier);

I am not in favor of this patch, and it only has one user, which makes
it more unwanted.

-- 
viresh
