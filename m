Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9374FC433F5
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 15:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A44860174
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 15:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhKFPTQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 Nov 2021 11:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhKFPTP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Nov 2021 11:19:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B02C061570;
        Sat,  6 Nov 2021 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=T9k+w06FwjbzHUtiFkZET+tVXhJuCL3KtuVic5fllVQ=; b=P3Dw2dKE6F5l4AFDIIbf3yENQB
        c6YDZFSuTM3sE/kunkR0n4IVERp+UiuGLYTE+IWw6jOWJpwnj+IJ5QrqgLJhYwtc57FIF6deiGsiK
        n7M7t2rlPTCIkJhxMJIYWAiDvROVqbipKKIONN3472ykGB9hvnA6p5fuHKKGazL03cDAejMq/8uqU
        W4S7rxjrtBCk5KWY23dAqsTqwcSQIRgrRGMROPEwy9ADxctZls9YiV0g37k5fWFp4iuzkL8rTZ0Ln
        rcqFA4f+CpqikywqIDs1bAC4zKrPJMuT9Kic1opRI68E4pcFViTcuSX3i+Wfa3k5gNtJzYQJuy1fO
        7YIhpUJQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjNQi-008ZCb-L7; Sat, 06 Nov 2021 15:16:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/2] mmc: Add mmc driver for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, Tony Huang <tony.huang@sunplus.com>
References: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com>
 <1636208598-18234-3-git-send-email-tony.huang@sunplus.com>
Message-ID: <3da7cacf-d5ab-9f08-6d15-a75cf952d43d@infradead.org>
Date:   Sat, 6 Nov 2021 08:16:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1636208598-18234-3-git-send-email-tony.huang@sunplus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[resending, had some kind of email error on the first try]

On 11/6/21 7:23 AM, Tony Huang wrote:
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index ccc148c..2a78cbc 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -14,6 +14,15 @@ config MMC_DEBUG
>   	  added host drivers please don't invent their private macro for
>   	  debugging.
>   
> +config MMC_SUNPLUS
> +	tristate "Sunplus SP7021 MMC Controller"
> +	depends on ARCH_SUNPLUS || SOC_I143 || SOC_Q645
> +	default y

Is this needed to be able to boot?  That's about the only
reason that "default y" could be justified.

> +	help
> +		If you say yes here, you will get support for eMMC host interface
> +		on sunplus Socs.

		   Sunplus SoCs.

> +		If unsure, say N.
> +		Sunplus  eMMC Host Controller v4.51 support"

What is that last line for?

And all lines of the help text should be indented with
one tab + 2 spaces per coding-style.rst.

thanks.
-- 
~Randy
