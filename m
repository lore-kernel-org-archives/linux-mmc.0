From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: cqhci: Ensure macro parameters are wrapped in parentheses
Date: Mon, 11 Dec 2017 13:29:35 +0100
Message-ID: <CAPDyKFo+_QuTCj2XfhAK+7iDVz79XNWe6qSTTwbssxNinZTVjg@mail.gmail.com>
References: <1512718266-31261-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:40816 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbdLKM3g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Dec 2017 07:29:36 -0500
Received: by mail-it0-f66.google.com with SMTP id f190so15308934ita.5
        for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2017 04:29:35 -0800 (PST)
In-Reply-To: <1512718266-31261-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Harjani Ritesh <riteshh@codeaurora.org>, Shawn Lin <shawn.lin@rock-chips.com>, Bough Chen <haibo.chen@nxp.com>

On 8 December 2017 at 08:31, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Absence of parentheses is not affecting current code, but ensure macro
> parameters are wrapped in parentheses.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: adcb39141800 ("mmc: cqhci: support for command queue enabled host")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci.h | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index 2d39d361b322..9e68286a07b4 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -61,9 +61,9 @@
>  #define CQHCI_IC_ENABLE                        BIT(31)
>  #define CQHCI_IC_RESET                 BIT(16)
>  #define CQHCI_IC_ICCTHWEN              BIT(15)
> -#define CQHCI_IC_ICCTH(x)              ((x & 0x1F) << 8)
> +#define CQHCI_IC_ICCTH(x)              (((x) & 0x1F) << 8)
>  #define CQHCI_IC_ICTOVALWEN            BIT(7)
> -#define CQHCI_IC_ICTOVAL(x)            (x & 0x7F)
> +#define CQHCI_IC_ICTOVAL(x)            ((x) & 0x7F)
>
>  /* task list base address */
>  #define CQHCI_TDLBA                    0x20
> @@ -119,31 +119,31 @@
>  #define CQHCI_IC_DEFAULT_ICTOVAL       1
>
>  /* attribute fields */
> -#define CQHCI_VALID(x)                 ((x & 1) << 0)
> -#define CQHCI_END(x)                   ((x & 1) << 1)
> -#define CQHCI_INT(x)                   ((x & 1) << 2)
> -#define CQHCI_ACT(x)                   ((x & 0x7) << 3)
> +#define CQHCI_VALID(x)                 (((x) & 1) << 0)
> +#define CQHCI_END(x)                   (((x) & 1) << 1)
> +#define CQHCI_INT(x)                   (((x) & 1) << 2)
> +#define CQHCI_ACT(x)                   (((x) & 0x7) << 3)
>
>  /* data command task descriptor fields */
> -#define CQHCI_FORCED_PROG(x)           ((x & 1) << 6)
> -#define CQHCI_CONTEXT(x)               ((x & 0xF) << 7)
> -#define CQHCI_DATA_TAG(x)              ((x & 1) << 11)
> -#define CQHCI_DATA_DIR(x)              ((x & 1) << 12)
> -#define CQHCI_PRIORITY(x)              ((x & 1) << 13)
> -#define CQHCI_QBAR(x)                  ((x & 1) << 14)
> -#define CQHCI_REL_WRITE(x)             ((x & 1) << 15)
> -#define CQHCI_BLK_COUNT(x)             ((x & 0xFFFF) << 16)
> -#define CQHCI_BLK_ADDR(x)              ((x & 0xFFFFFFFF) << 32)
> +#define CQHCI_FORCED_PROG(x)           (((x) & 1) << 6)
> +#define CQHCI_CONTEXT(x)               (((x) & 0xF) << 7)
> +#define CQHCI_DATA_TAG(x)              (((x) & 1) << 11)
> +#define CQHCI_DATA_DIR(x)              (((x) & 1) << 12)
> +#define CQHCI_PRIORITY(x)              (((x) & 1) << 13)
> +#define CQHCI_QBAR(x)                  (((x) & 1) << 14)
> +#define CQHCI_REL_WRITE(x)             (((x) & 1) << 15)
> +#define CQHCI_BLK_COUNT(x)             (((x) & 0xFFFF) << 16)
> +#define CQHCI_BLK_ADDR(x)              (((x) & 0xFFFFFFFF) << 32)
>
>  /* direct command task descriptor fields */
> -#define CQHCI_CMD_INDEX(x)             ((x & 0x3F) << 16)
> -#define CQHCI_CMD_TIMING(x)            ((x & 1) << 22)
> -#define CQHCI_RESP_TYPE(x)             ((x & 0x3) << 23)
> +#define CQHCI_CMD_INDEX(x)             (((x) & 0x3F) << 16)
> +#define CQHCI_CMD_TIMING(x)            (((x) & 1) << 22)
> +#define CQHCI_RESP_TYPE(x)             (((x) & 0x3) << 23)
>
>  /* transfer descriptor fields */
> -#define CQHCI_DAT_LENGTH(x)            ((x & 0xFFFF) << 16)
> -#define CQHCI_DAT_ADDR_LO(x)           ((x & 0xFFFFFFFF) << 32)
> -#define CQHCI_DAT_ADDR_HI(x)           ((x & 0xFFFFFFFF) << 0)
> +#define CQHCI_DAT_LENGTH(x)            (((x) & 0xFFFF) << 16)
> +#define CQHCI_DAT_ADDR_LO(x)           (((x) & 0xFFFFFFFF) << 32)
> +#define CQHCI_DAT_ADDR_HI(x)           (((x) & 0xFFFFFFFF) << 0)
>
>  struct cqhci_host_ops;
>  struct mmc_host;
> --
> 1.9.1
>
