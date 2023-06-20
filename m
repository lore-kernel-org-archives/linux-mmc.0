Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64359EB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 11:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjFTLPz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 07:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjFTLPx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 07:15:53 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698110F2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 04:15:49 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5700e993f37so82898457b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259749; x=1689851749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UTJ67mS9SvC0pSNtNpiCqHOEuN5wLdpb3QMuy8p1m6o=;
        b=iPXAZdzWUltY2lbMf99y0eQoA52muRuVrmJP3Un9Ge0/M4BU3rOK2y9DWX4oyH3ft4
         ZqE3FHZyT1MfQyV/sTfOqJl+E6Pyal2/pvo9Zl0Nl7pVBD/eNZBfCpxlbnAg1KYi/AkB
         e5qYjMF+uja6js2W650jInQ18HcD5kuD83Hrc5YjSEwItEb0yhXZq9ywWmR88NvZ2D/j
         djwMuImAx2wOqJqMZcJlug+ind2Ne23DYntbxQgTT5gnjhbjP9NNkeT3F5x5PpZU5CD8
         Sp1i/xU5qjljeoRsbTtOIL0DcFujm2Q0mDj2AgqtCKsqGEHfN/Qu5qe/gRKSYvs8ilbn
         xwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259749; x=1689851749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTJ67mS9SvC0pSNtNpiCqHOEuN5wLdpb3QMuy8p1m6o=;
        b=FOGbEnODnKZPqBv+eL9RaGnCS/SoamXiasA0pso26XU9iNZxXpOK58pAPsvPFteisH
         eWQoj62CXzOmkJWoxO/otJZ5VuNdaGp4X3ANoE+UurP0W1lucXdhHBQQfdmc2gj0Psvo
         qwGWmbN7Gm05HVT6BzyPckcx2Xzm5O5VlIOOs5eAIwQtnMnZP61gXzsHf8yQ7uEZDk7f
         5iq0IQzUwyr8rmtoVloj/xT6gp/ZJ7xh4pv45RC4RGhcC7yMShpPVmHLJaPdCU05O+EC
         lmsTCNFpMkNbAl8uhDLWD3iI8k2SkpVN9j5KYnBNjxGkakAGoOJbv0poV1B2InEX88KJ
         wSnw==
X-Gm-Message-State: AC+VfDxbH9czd+++oske5vhZCy+66CtgdiXsZuqyJUnW2iopURviFfgA
        S+xjuuJp64tJj2jUTHS/Lp2KcjTDFIdvgA9cz/5WZw==
X-Google-Smtp-Source: ACHHUZ4CszfWWRsVvp4i3LTxMl7NDJhwSHpkulEoEvpbiT8IMT9OvNP7aBmb53b2PeaS4hAXtrHQ5OVQgp+lI89gXCI=
X-Received: by 2002:a25:accc:0:b0:bc3:e175:65ed with SMTP id
 x12-20020a25accc000000b00bc3e17565edmr8279088ybd.22.1687259748962; Tue, 20
 Jun 2023 04:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230620104722.16465-1-marex@denx.de>
In-Reply-To: <20230620104722.16465-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Jun 2023 13:15:13 +0200
Message-ID: <CAPDyKFqZ_r=gjpRm833ax4LwASCTGAuO0a0ABXo-kN8dtYje-Q@mail.gmail.com>
Subject: Re: [PATCH 01/11] mmc: core: Use BIT() macro
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>, Bo Liu <liubo03@inspur.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Jun 2023 at 12:47, Marek Vasut <marex@denx.de> wrote:
>
> Use the BIT(n) macro instead of (1<<n), no functional change.
> Regex 's@(1 \?<< \?\([0-9A-Z_]\+\))@BIT(\1)' .
>
> Signed-off-by: Marek Vasut <marex@denx.de>

I don't think the benefit of this change is worth it. For example,
it's quite useful to run a git blame to see the history of what has
happened.

So, sorry, but I am not going to pick this up - or any other similar
changes, at least for the core layer.

Kind regards
Uffe

> ---
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Bo Liu <liubo03@inspur.com>
> Cc: Deren Wu <deren.wu@mediatek.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: linux-mmc@vger.kernel.org
> ---
>  include/linux/mmc/core.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 6efec0b9820c1..23db84630ae8a 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -26,16 +26,16 @@ enum mmc_blk_status {
>  struct mmc_command {
>         u32                     opcode;
>         u32                     arg;
> -#define MMC_CMD23_ARG_REL_WR   (1 << 31)
> +#define MMC_CMD23_ARG_REL_WR   BIT(31)
>  #define MMC_CMD23_ARG_PACKED   ((0 << 31) | (1 << 30))
> -#define MMC_CMD23_ARG_TAG_REQ  (1 << 29)
> +#define MMC_CMD23_ARG_TAG_REQ  BIT(29)
>         u32                     resp[4];
>         unsigned int            flags;          /* expected response type */
> -#define MMC_RSP_PRESENT        (1 << 0)
> -#define MMC_RSP_136    (1 << 1)                /* 136 bit response */
> -#define MMC_RSP_CRC    (1 << 2)                /* expect valid crc */
> -#define MMC_RSP_BUSY   (1 << 3)                /* card may send busy */
> -#define MMC_RSP_OPCODE (1 << 4)                /* response contains opcode */
> +#define MMC_RSP_PRESENT        BIT(0)
> +#define MMC_RSP_136    BIT(1)          /* 136 bit response */
> +#define MMC_RSP_CRC    BIT(2)          /* expect valid crc */
> +#define MMC_RSP_BUSY   BIT(3)          /* card may send busy */
> +#define MMC_RSP_OPCODE BIT(4)          /* response contains opcode */
>
>  #define MMC_CMD_MASK   (3 << 5)                /* non-SPI command type */
>  #define MMC_CMD_AC     (0 << 5)
> @@ -43,10 +43,10 @@ struct mmc_command {
>  #define MMC_CMD_BC     (2 << 5)
>  #define MMC_CMD_BCR    (3 << 5)
>
> -#define MMC_RSP_SPI_S1 (1 << 7)                /* one status byte */
> -#define MMC_RSP_SPI_S2 (1 << 8)                /* second byte */
> -#define MMC_RSP_SPI_B4 (1 << 9)                /* four data bytes */
> -#define MMC_RSP_SPI_BUSY (1 << 10)             /* card may send busy */
> +#define MMC_RSP_SPI_S1 BIT(7)          /* one status byte */
> +#define MMC_RSP_SPI_S2 BIT(8)          /* second byte */
> +#define MMC_RSP_SPI_B4 BIT(9)          /* four data bytes */
> +#define MMC_RSP_SPI_BUSY BIT(10)               /* card may send busy */
>
>  /*
>   * These are the native response types, and correspond to valid bit
> --
> 2.39.2
>
