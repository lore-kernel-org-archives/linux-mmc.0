Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E08FC43381
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 21:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09951216FD
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 21:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbhAYVsr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:48:47 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:35571 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733005AbhAYVim (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2021 16:38:42 -0500
Received: by mail-ot1-f51.google.com with SMTP id 36so14275651otp.2;
        Mon, 25 Jan 2021 13:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XQtlQwc0CWDU+/5MkfFrUYSWDoYjbHyLw6ppWMy86ZE=;
        b=n3IIAdfby7QYFxcsuDV2PCENDn+zLd96GQmpxPF4LxKHe8FFVZ8o94DxxD9Izg5cnC
         H2hzBvxp5+lAphb98JPrR6Dx3W2LHKLtm9N3/pYRGDQkfK95CXYRryAyWwBYSNDpQ+hS
         PI96r1syfwavVF9Gn4n6nspXwRqQYA7LSJzzT8hP+hYoP4RTXPcR2fRpMBHmRMpuwJhZ
         MsJ9yqFAINihvthKwZxVf3kJNdev1bkFYcdBID9mCPCWx6Lu+mmAAbj1+52cUmMHmaBM
         OVl1WmLSk3zFPzAJo4Nxe+yihK5f+BE4EJjzB4bvhXzwSIjQNuX8l/flXYWN7Vd4N8R/
         dcQA==
X-Gm-Message-State: AOAM530C1s7R8vhDI2RZ2IH8PO6AKNjh++gp5ARmy0MDMzns1vIBFW1c
        4VR+vs8ZQpC0D7QAV78Uew==
X-Google-Smtp-Source: ABdhPJyjZXPw+jRnyybOSzoUCwDlCfYOukQtsSAE9rpKrpjbp9vPdfxePbD7VOY7Bkz61SeMMWPyaQ==
X-Received: by 2002:a9d:5e0f:: with SMTP id d15mr1805348oti.308.1611610680316;
        Mon, 25 Jan 2021 13:38:00 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p4sm3799500oib.24.2021.01.25.13.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:37:59 -0800 (PST)
Received: (nullmailer pid 1048034 invoked by uid 1000);
        Mon, 25 Jan 2021 21:37:58 -0000
Date:   Mon, 25 Jan 2021 15:37:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rashmi.A@intel.com, mahesh.r.vaidya@intel.com
Subject: Re: [PATCH v1 9/9] mmc: sdhci-of-arasan: Add UHS-1 support for Keem
 Bay SOC
Message-ID: <20210125213758.GA1026926@robh.at.kernel.org>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-10-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114152700.21916-10-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 14, 2021 at 11:27:00PM +0800, Muhammad Husaini Zulkifli wrote:
> Keem Bay SOC can support dual voltage operations for GPIO SD pins to
> either 1.8V or 3.3V for bus IO line power. In order to operate the GPIOs
> line for Clk, Cmd and Data on Keem Bay hardware, it is important to
> configure the supplied voltage applied to their I/O Rail and the output
> of the I²C expander pin. Final Voltage applied on the GPIOs line are
> dependent by both supplied voltage rail and expander pin output as it is
> been set after passing through the voltage sense resistor.
> 
> Keem Bay hardware is somewhat unique in the way of how IO bus line
> voltage are been controlled.
> 
> Expander pin output is controlled by gpio-regulator. Voltage rail output
> is controlled by Keem Bay SD regulator. Keem Bay SD regulator encapsulated
> the Secure Monitor Calling Convention (SMCCC) to communicate with Trusted
> Firmware during set voltage operation.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 263 +++++++++++++++++++++++++++++
>  1 file changed, 263 insertions(+)

> +	u32 otap_delay, sel_clk_buffer;
> +
> +	phys = of_parse_phandle(dev->of_node, "phys", 0);

Normally, you'd use the phy API here. Though not required from a DT 
perspective.

> +	if (!phys) {
> +		dev_err(dev, "Can't get phys for sd0\n");
> +		return -ENODEV;
> +	}
> +
> +	of_property_read_u32(phys, "intel,keembay-emmc-phy-otap-dly", &otap_delay);
> +	of_property_read_u32(phys, "intel,keembay-emmc-phy-sel-clkbuf", &sel_clk_buffer);

Not doucmented?

For property names, I'd leave out the SoC name. Might want to use it in 
the next chip.

Rob
