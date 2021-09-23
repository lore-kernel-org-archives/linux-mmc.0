Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57FBC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32EE61029
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbhIWSvq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242768AbhIWSvp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 14:51:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C097BC061574
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u18so28782981lfd.12
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gGXok9C2zJwna124nPWk+7zhfwPZ1Gc6OCclICzrU9s=;
        b=tF4NIGAYXmKJ/H3ElgS0dtGh5wnxcOEkstv9geZ8CLJSG7VESZWmjZPkPRe2gtBgSu
         BeOR4O5npXiBdl+y6GEeutpjj8++GniiM3Q8bzTW72t1SQBNzMgklig3FUx+Ps4q6WOO
         ONZExqJAj9rCHQDCreTVWxyF5/YupkU7KE9FasMcQSDR7ibIDieIL4wEx5EmUZSoqSG7
         rgnRL5dsU0+dLVLIG600iulp2QytIf1RRaRyp8qdx0AcQm8eQ+eftf/zqDakgs6kve4u
         IN6+h9A1q3Yklm9Edt7XyiuBR8MN2dHG8HGeGg3SuuCh60zK13BUiLeF0HEho43lciHJ
         5dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gGXok9C2zJwna124nPWk+7zhfwPZ1Gc6OCclICzrU9s=;
        b=XWxsf8TG0z51OjGQykPb59TBGwg6ISQPKJnKfu6m9H8lLtGziDiCpU54X8JYTOq+wg
         oX8kWMgFfibKVqQB9BjA3deyoxy/9UuKjMFk6OojdaZgC7LhG2s7SZDzq0VdwJ2EK/VR
         CM1QZzejl6aqDsMYDdtS5zBF92A2kmkgTFy+7cTKzj7H1DbhtW3niSYo+Tnzj248L3+Y
         VPpyJOQRY/R51+nHrUgmm2+mivSNGzBURXuLW7tjdN3e3y4fmeLMvTxZjF09oKrATw5m
         4tzKHoEgSMq5LZnYa7/zdp50LgZUDzsQtvDJTsfqRY9xqPWNc8RzIQ/uJCRBXjsIYF70
         8Z6g==
X-Gm-Message-State: AOAM532B+HEPNjHFxZM9oppGayhUNiJT/ULtSYh68W/JuYpX+RCVDgJ5
        TOFnTqYRYZ+vdW5slDp1YbGYFf73R+UYncikmIu03U+xgFA=
X-Google-Smtp-Source: ABdhPJz/3jM+HCenFQ1gKxUxySNubtYcaPRo7nshJex5Hy+YMoHfq+kEtsAKYVRqCqeAyDXzSo+nzfhy17UjRv6dItM=
X-Received: by 2002:a2e:85c2:: with SMTP id h2mr6940282ljj.367.1632423012098;
 Thu, 23 Sep 2021 11:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <af8f8b8674ba4fcc9a781019e4aeb72c@hyperstone.com>
In-Reply-To: <af8f8b8674ba4fcc9a781019e4aeb72c@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:49:35 +0200
Message-ID: <CAPDyKFqD=KKgSC1PQz_RVm=sGMWtdFsaHSHDiKDxMKajbkszMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Dont wait for DRTO on Write RSP error
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Sept 2021 at 07:59, Christian L=C3=B6hle <CLoehle@hyperstone.com=
> wrote:
>
> Only wait for DRTO on reads, otherwise the driver hangs.
>
> The driver prevents sending CMD12 on response errors like CRCs.
> According to the comment this is because some cards have problems
> with this during the UHS tuning sequence.
> Unfortunately this workaround currently also applies for any command
> with data.
> On reads this will set the drto timer which then triggers after a while.
> On writes this will not set any timer and the tasklet will not be
> scheduled again.
> I cannot attest for the UHS workarounds need, but even if so, it should
> at most apply to reads.
> I have observed many hangs when CMD25 response contained a CRC error.
> This patch fixes this without touching the actual UHS tuning workaround.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied for next and by adding a stable tag, thanks!

If you don't think we need the stable tag, please tell me.

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..22cf13dc799b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2081,7 +2081,8 @@ static void dw_mci_tasklet_func(struct tasklet_stru=
ct *t)
>                                  * delayed. Allowing the transfer to take=
 place
>                                  * avoids races and keeps things simple.
>                                  */
> -                               if (err !=3D -ETIMEDOUT) {
> +                               if (err !=3D -ETIMEDOUT &&
> +                                   host->dir_status =3D=3D DW_MCI_RECV_S=
TATUS) {
>                                         state =3D STATE_SENDING_DATA;
>                                         continue;
>                                 }
> --
> 2.32.0
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
