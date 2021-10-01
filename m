Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997FEC433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Oct 2021 12:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFBD619F8
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Oct 2021 12:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354425AbhJAMoL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Oct 2021 08:44:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:16072 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354422AbhJAMoL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Oct 2021 08:44:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633092147; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=oebx3fcM3g966gWCz22lzF59IX1zMeaSKJn177/dREs=; b=HhJAyS9S2zcg0YIBeYaxA2HepJR501SF+ol1Q0FOiGX0WVIZN/Oy3BfYISDQtRosXk6lScZA
 yPFDMwqjYMzR0ldHzPREFQuKPx+7y6pyptMWGQ7vqkicsHtcvloMEUPC1BIEOgJap7DIM6Pj
 oTZ7PC3F9EA5T03iZxWBh5JRYTQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6157022b8578ef11ed835004 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 12:42:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F029DC4360C; Fri,  1 Oct 2021 12:42:18 +0000 (UTC)
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 782CDC43460;
        Fri,  1 Oct 2021 12:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 782CDC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        Pali =?utf-8?Q?Roh?= =?utf-8?Q?=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 00/24] wfx: get out from the staging area
References: <20210920161136.2398632-1-Jerome.Pouiller@silabs.com>
Date:   Fri, 01 Oct 2021 15:42:13 +0300
In-Reply-To: <20210920161136.2398632-1-Jerome.Pouiller@silabs.com> (Jerome
        Pouiller's message of "Mon, 20 Sep 2021 18:11:12 +0200")
Message-ID: <87bl48kjbu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:

> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> Hello,
>
> I think the wfx driver is now mature enough to be accepted in the
> drivers/net/wireless directory.
>
> The firmware is now a part of the linux-firmware repository since relase
> 20210315[1]. It had taken a bit of time because I have worked with the le=
gal
> department to simplify the redistribution terms of the firmware.
>
> [1]: https://lore.kernel.org/linux-firmware/2833354.gXvVfaC4I7@pc-42/
>
>
> As requested by Kalle[2], I send one file per patch. At the end, all the
> patches (or at least the patches 3 to 24) will be squashed (therefore, I
> didn't bother to write real commit messages).

I did another review of the driver and in general it looks pretty good.
The use of Apache license, PDS file format and the missing firmware
directory are the biggest issues I saw.

> v7:
>   - Update location of mmc-pwrseq-simple.txt (Rob)
>
> v6:
>   - Rebase on last staging-next (roughtly somewhere after the 5.15
>     merge window). So, this series include the patches from:
>       https://lore.kernel.org/netdev/20210913130203.1903622-1-Jerome.Poui=
ller@silabs.com/

BTW, it would be nice to know what commit id are you using from
staging-next, I prefer to also look at the full tree while I'm reviewing
the patches.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
