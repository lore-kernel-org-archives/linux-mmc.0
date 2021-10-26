Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A606C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 00:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2C360F70
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 00:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhJZAeN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Oct 2021 20:34:13 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59253 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234518AbhJZAeM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Oct 2021 20:34:12 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 913B3580760;
        Mon, 25 Oct 2021 20:31:48 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Mon, 25 Oct 2021 20:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=yGoSd29Cl/DpdxjWB405Kt4Sp2gFWlM
        pymgEnWabDSc=; b=G5hbVnk0JCzsRgIKCE/zxmoYd6SCcVHCbTJ+dq+ACnXagec
        iSCGQ7oc54Xnjt5E5RLshmhz+tplC9zrFFTMcVuLu/dJyLB37A5VCUm4P6xUecvK
        4MBTqH2xwfFIOS6wk5rrTgmzscT23IG/Flxuhmnb/OV62ziW4VvIgg+OG950tROR
        A6jWF8DMuE84bAOE+5UzqviLa8vFgUHctbuGhBoIi+iEjesbWrezhDBcG+iN2Neu
        W4Ierywl+bU2bvRzyYUrDOPX3XKIEXzGXZ6lBkpXCEUuye079Ib14dwux/htr09M
        7Fk9Fw4eXhA3x0YJ43OS8+2oXdxZEtBFMm1ggmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yGoSd2
        9Cl/DpdxjWB405Kt4Sp2gFWlMpymgEnWabDSc=; b=H6NSn7PfoZYoJsdI00BkD8
        ZLcFJreGwwR+oCgmERVQjkeV2Dwr2mjJ4stGIqGRjlwPEteX5/2fuG6pc6QrWQky
        NA5rDmD8E+0ApDejrxxn/bkbLSwL/tgP5jOjE69AMoCFh7iSF3S+LeVosNt/VL/r
        LexgmDGPzazWT4BtmNQyQFPgjuv4yz/dh8+CK2cWcNhTUhYvbUDvShp0QeGt+yDB
        E/vGE5EBbEPCNxgBk+zPgAqHzahQesU3viyQ3zMriy9I/0GJyhNIM3fb36SewzK5
        ufy2OsjcshliEGICJWU/U8HGUhwBCCPcM5DnqcaNcw71S043ZeVEOUE//ghwkQwg
        ==
X-ME-Sender: <xms:ckx3YSmWA47RG7TypvFraRZdeEJT5RmoQAYnfB9SezwsseoI6bu-1g>
    <xme:ckx3YZ3hMfTxOIa_hMNKi1KO-C64ei5HpM6kG_0_YVMCwD_X1pZZ2gIhWuocZbaGt
    Q9eC60oMWQ2grq5Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefiedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:ckx3YQp2DORzmZFcnyrDUbEgLjmB651RleT8wCWVflujcIkzNhRXrg>
    <xmx:ckx3YWmqdg0WxajkV4mm3SvCnP9dsgV3cSNbw6CkZWP3esFswIq01g>
    <xmx:ckx3YQ2psLu7AFkqHm9P2oP8NNwIW42wNoY3T2Uqe5GKCI-v0QEykw>
    <xmx:dEx3YWNg6tgtgPfBxS4KDgRZLUHZVorYD5ucY1BqXBvG1qYtIgMreA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D76FCAC03DB; Mon, 25 Oct 2021 20:31:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <125453f3-55d5-4b2a-afe8-6e76b268ce01@www.fastmail.com>
In-Reply-To: <20210922103116.30652-3-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-3-chin-ting_kuo@aspeedtech.com>
Date:   Tue, 26 Oct 2021 11:01:26 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, "Steven Lee" <steven_lee@aspeedtech.com>
Subject: Re: [PATCH 02/10] sdhci: aspeed: Add SDR50 support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Chin-Ting,

Sorry for the delay in looking at your series.

On Wed, 22 Sep 2021, at 20:01, Chin-Ting Kuo wrote:
> From the analog waveform analysis result, SD/SDIO controller
> of AST2600 cannot always work well with 200MHz. The upper bound
> stable frequency for SD/SDIO controller is 100MHz. Thus, SDR50
> supported bit, instead of SDR104, in capability 2 register
> should be set in advance.
>
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c 
> b/drivers/mmc/host/sdhci-of-aspeed.c
> index 6e4e132903a6..c6eaeb02e3f9 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -35,6 +35,8 @@
>  #define ASPEED_SDC_CAP1_1_8V           (0 * 32 + 26)
>  /* SDIO{14,24} */
>  #define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
> +/* SDIO{14,24} */

I don't think we need to duplicate this comment.

> +#define ASPEED_SDC_CAP2_SDR50          (1 * 32 + 0)

Can we keep the defines in increasing bit order (i.e. put 
ASPEED_SDC_CAP2_SDR50 above ASPEED_SDC_CAP2_SDR104)?

> 
>  struct aspeed_sdc {
>  	struct clk *clk;
> @@ -410,11 +412,17 @@ static int aspeed_sdhci_probe(struct 
> platform_device *pdev)
>  	sdhci_get_of_property(pdev);
> 
>  	if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
> +		of_property_read_bool(np, "sd-uhs-sdr50") ||

Minor formatting issue, but can you make sure all the conditions are 
aligned vertically from the left?

>  	    of_property_read_bool(np, "sd-uhs-sdr104")) {
>  		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP1_1_8V,
>  					       true, slot);
>  	}
> 
> +	if (of_property_read_bool(np, "sd-uhs-sdr50")) {
> +		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP2_SDR50,
> +					       true, slot);
> +	}
> +
>  	if (of_property_read_bool(np, "sd-uhs-sdr104")) {
>  		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP2_SDR104,
>  					       true, slot);
> -- 
> 2.17.1
