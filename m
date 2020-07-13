Return-Path: <SRS0=k+AD=AY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748ACC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jul 2020 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC8420738
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jul 2020 14:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IO3oScen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgGMOjd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:39:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41503 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMOjc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Jul 2020 10:39:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594651171; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=RbZonCviqU0Iw3ZoaD2UXTdlv+ufrHYsECP40xt9bL8=; b=IO3oScenfkEsq1O8J+jI0zFEsNfnUQw1SJCzyQg7HYnMWfxdVFTgI6aRoEfTgRwrzvgu7KUI
 FnakMVj9IQlPAf1pwu0sYNCFwAYDFjFLWRcFzmAtJEitucnIzf06AbX47Xs8rLsCsvZEATQo
 x8vvE5ChBDH+7mqSy/TvaeyZdQo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f0c72022991e765cd4ef3ff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Jul 2020 14:38:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6FA8C433CA; Mon, 13 Jul 2020 14:38:57 +0000 (UTC)
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D742C433C8;
        Mon, 13 Jul 2020 14:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D742C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdio: Move SDIO IDs from rsi_sdio driver to common include file
References: <20200629072144.24351-1-pali@kernel.org>
        <CAPDyKFp-meAG4XNgL3ixacYKpFByV-Pynz6-GRDtfT95hC-Jmw@mail.gmail.com>
Date:   Mon, 13 Jul 2020 17:38:53 +0300
In-Reply-To: <CAPDyKFp-meAG4XNgL3ixacYKpFByV-Pynz6-GRDtfT95hC-Jmw@mail.gmail.com>
        (Ulf Hansson's message of "Mon, 6 Jul 2020 16:49:17 +0200")
Message-ID: <87eepfxywy.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Mon, 29 Jun 2020 at 09:22, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>
>> Define appropriate macro names for consistency with other macros.
>>
>> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> Applied for next, thanks!
>
> If it turns out that it's a better idea to funnel this via Kale's
> wireless tree, then I can drop it - and you may consider this as an
> ack instead.

I'm not expecting any conflicts with this so going via mmc tree is fine
with me.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
