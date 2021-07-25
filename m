Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27043C4338F
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0385360551
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 21:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhGYVA7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jul 2021 17:00:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:45905 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhGYVA6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jul 2021 17:00:58 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210725214126epoutp02da4f5bb2060e1cb13eebdb8b1040ffb7~VJprWAD5P1948919489epoutp02s
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jul 2021 21:41:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210725214126epoutp02da4f5bb2060e1cb13eebdb8b1040ffb7~VJprWAD5P1948919489epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1627249286;
        bh=j9ZevLtWhCUcjcrCJTcEbmH/pgFvB970zigRDFlgMqk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=c0NDksmjOiFFrSSYA2he3dSrt2JmbA+990JTX2FjBkcCaGnL+XiIiQ3GT9dAQmja2
         GGQleNdtHqAGwB6vaBZS7AFWMCFpsBtmmxvvKcy0JRei1RTBObnH5HCBSNmwDXG8TH
         8y0xTQremVKaVjHuRBKi50y7ePWcETgygQJIsxIw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210725214126epcas1p385ffc74e65926644d14e6fca9e9c5b2d~VJpq_JcVu0927009270epcas1p3m;
        Sun, 25 Jul 2021 21:41:26 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GXxMS2ZYnz4x9Pp; Sun, 25 Jul
        2021 21:41:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.46.09551.48ADDF06; Mon, 26 Jul 2021 06:41:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210725214123epcas1p1b350809ad349aadd21f73f7759cc3f6b~VJpolciyp2568425684epcas1p1J;
        Sun, 25 Jul 2021 21:41:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210725214123epsmtrp2357392b8980455bc6515c35184af5629~VJpokyKgx2625426254epsmtrp2Z;
        Sun, 25 Jul 2021 21:41:23 +0000 (GMT)
X-AuditID: b6c32a36-2b3ff7000000254f-ef-60fdda844247
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.59.08394.38ADDF06; Mon, 26 Jul 2021 06:41:23 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210725214123epsmtip188ef1eeb9b0323904a50345d2498a8ed~VJpoWiymz2377623776epsmtip1w;
        Sun, 25 Jul 2021 21:41:23 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: Fix hang on data CRC error
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <9c1ae48f-f60a-0dd9-00f0-84ef60da68e5@samsung.com>
Date:   Mon, 26 Jul 2021 06:42:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630102232.16011-1-vincent.whitchurch@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTQLfl1t8Eg955AhafWlQtLu+aw2Zx
        5H8/o8XxteEW57f5O7B6XF8X4HHn2h42j8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od
        403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0ts
        lVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyMz633mUs6BequDFrHnsD41/eLkZODgkB
        E4mO5bPZuhi5OIQEdjBKzOvcAeV8YpRYtWETM4TzjVHi8Zt3bDAt3zd0sEIk9jJKNLZtZYRw
        3jNKfF5zjhmkSljARuLivStgHSICMRJPezaC2cwCPhJXpxxmBLHZBHQktn87zgRi8wrYSbzc
        84wVxGYRUJV43L0IrEZUIFLi/O4FLBA1ghInZz4BszkFHCUmzNgGNVNc4taT+UwQtrzE9rdz
        wM6WEHjELjGp7TjU2S4Si699Z4ewhSVeHd8CZUtJfH63F6qmWmJX8xmo5g5GiVvbmpggEsYS
        +5dOBrI5gDZoSqzfpQ8RVpTY+XsuI8RiPol3X3tYQUokBHglOtqEIEpUJC69fskEs+ruk/+s
        ELaHRMv97WwTGBVnIXltFpJ3ZiF5ZxbC4gWMLKsYxVILinPTU4sNC4yQo3sTIzgtapntYJz0
        9oPeIUYmDsZDjBIczEoivA4rficI8aYkVlalFuXHF5XmpBYfYjQFBvZEZinR5HxgYs4riTc0
        NTI2NrYwMTQzNTRUEuf9Fvs1QUggPbEkNTs1tSC1CKaPiYNTqoFp5kPHMNMrF5t3RSsvEboY
        xif4WmF53J7ljzVMHsf/DV27sWTqXY9nece/671PkLIuPhTVxLxzgjrnxKefLz4PaGK8Hb7z
        3uI/Uz8E2JdfC+z732Ec45wVrxxeXvxPSeF/7sSg++diHugt2Hy2y1LqusSZaztNL6h/PhUw
        mYFPpFPGNuD5LtW7s75xmf2MLppqveOl3deYOZwRSy5kZc96EXA58+xH5sYrU/tvdF1r3/Wh
        Wsc0T1va7dzLpy7Pbe7zipYcXfQ03TRNP+hnpbzcywcTpRd9umv4VeeSx/H+Ox0rmzVfbslm
        +VR6kJFTw0ZG/+pMy0TtGgWdZyytte56ug8TH8wSnOf/prskMchYiaU4I9FQi7moOBEA3MSx
        1RQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnG7zrb8JBk3TdSw+tahaXN41h83i
        yP9+Rovja8Mtzm/zd2D1uL4uwOPOtT1sHp83yQUwR3HZpKTmZJalFunbJXBlfG69y1jQL1Rx
        Y9Y89gbGv7xdjJwcEgImEt83dLCC2EICuxklHkythYhLSXx+OpWti5EDyBaWOHy4uIuRC6jk
        LaPE1ltrmUBqhAVsJC7eu8IGYosIxEjsfPUMzGYW8JG4OuUwI8TMKYwSB5eXgdhsAjoS278d
        B+vlFbCTeLnnGdheFgFVicfdi8DqRQUiJT4veMUKUSMocXLmExYQm1PAUWLCjG1Q89Ul/sy7
        xAxhi0vcejKfCcKWl9j+dg7zBEahWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1
        ihNzi0vz0vWS83M3MYJjQEtzB+P2VR/0DjEycTAeYpTgYFYS4XVY8TtBiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBialLdfNt8l8unRK7EvSfmfn6fLP
        XqpuPDfRWvdu/T/3INFtnX8dzC9EF0Yydn+80MORZz1JX6Pwf8ZOw6qnHSUhq/kOH1327cOZ
        iHV8V1UDY0yy/0/TUymJfJdvri263uK4+kn2rsg9dRLsDgYJtziXvirXqzonLtL/KWylq8Z1
        Ze7iHCEpmS+PFim9mbDce3Xqa7nyN+E3gvW3SM5OmR7QJ/780JUT76yvbfSZYs+wu3LD66CP
        QjqONwrWv2oXnXp2Van96b7tc3n5Y7LV1zxeft484rdpQVBwN3Ogjs6O5tRphQ/z/WUrOCtn
        JO9aXJT1+7ul9DK39TqyDYsvy56+4HXjmFZoxmK7IHYDMyWW4oxEQy3mouJEAJlxTNPwAgAA
X-CMS-MailID: 20210725214123epcas1p1b350809ad349aadd21f73f7759cc3f6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210630102239epcas1p1bf7a5b65c7e588bbdc908b18c00a0025
References: <CGME20210630102239epcas1p1bf7a5b65c7e588bbdc908b18c00a0025@epcas1p1.samsung.com>
        <20210630102232.16011-1-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/30/21 7:22 PM, Vincent Whitchurch wrote:
> When a Data CRC interrupt is received, the driver disables the DMA, then
> sends the stop/abort command and then waits for Data Transfer Over.
> 
> However, sometimes, when a data CRC error is received in the middle of a
> multi-block write transfer, the Data Transfer Over interrupt is never
> received, and the driver hangs and never completes the request.
> 
> The driver sets the BMOD.SWR bit (SDMMC_IDMAC_SWRESET) when stopping the
> DMA, but according to the manual CMD.STOP_ABORT_CMD should be programmed
> "before assertion of SWR".  Do these operations in the recommended
> order.  With this change the Data Transfer Over is always received
> correctly in my tests.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f85271f5c4fa..845b0745ea37 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2083,8 +2083,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>  					continue;
>  				}
>  
> -				dw_mci_stop_dma(host);
>  				send_stop_abort(host, data);
> +				dw_mci_stop_dma(host);
>  				state = STATE_SENDING_STOP;
>  				break;
>  			}
> @@ -2108,10 +2108,10 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>  			 */
>  			if (test_and_clear_bit(EVENT_DATA_ERROR,
>  					       &host->pending_events)) {
> -				dw_mci_stop_dma(host);
>  				if (!(host->data_status & (SDMMC_INT_DRTO |
>  							   SDMMC_INT_EBE)))
>  					send_stop_abort(host, data);
> +				dw_mci_stop_dma(host);
>  				state = STATE_DATA_ERROR;
>  				break;
>  			}
> @@ -2144,10 +2144,10 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>  			 */
>  			if (test_and_clear_bit(EVENT_DATA_ERROR,
>  					       &host->pending_events)) {
> -				dw_mci_stop_dma(host);
>  				if (!(host->data_status & (SDMMC_INT_DRTO |
>  							   SDMMC_INT_EBE)))
>  					send_stop_abort(host, data);
> +				dw_mci_stop_dma(host);
>  				state = STATE_DATA_ERROR;
>  				break;
>  			}
> 

