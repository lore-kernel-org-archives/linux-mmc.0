Return-Path: <SRS0=5vaz=BW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337C7C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133CE20B1F
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 20:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IlNtlpm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHLUAU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:00:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:49737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgHLUAT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Aug 2020 16:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597262395;
        bh=KtVP+9CoE4x+P4vIm7WdD2oTdBMHgUjg2pO7nFUsGy4=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=IlNtlpm9OvaMM5ly6CLvZ7pQXLwCegnuqg5V5ukfCW1CpTOPLBuUhZab8AUTKS3CD
         REEUQ3yi7TUrVXEMQ3SmlH5d2yYh2pa/xxu1J3QzlyV50hF7WWatiAdyM9PiKqSwpE
         h8ouvPU1jf+4AQKIz87eyv+3SdU6W6Y38VM0Kw88=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([37.60.0.210]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hVB-1k1qJ80Cen-004kFf; Wed, 12
 Aug 2020 21:59:55 +0200
Date:   Wed, 12 Aug 2020 21:59:48 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <f65aeebb6c372a7138e496a30ce39f879d4e24ed.camel@pengutronix.de>
References: <20200812093726.10123-1-wenbin.mei@mediatek.com> <20200812093726.10123-4-wenbin.mei@mediatek.com> <f65aeebb6c372a7138e496a30ce39f879d4e24ed.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] mmc: mediatek: add optional module reset property
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <68A53B8B-6646-4A99-B1E3-FAC3D550D67E@public-files.de>
X-Provags-ID: V03:K1:vDQU52f3FqwgkLuBMaKcXThRs6qVswcU8BOJ+WZ5ghW9KrzJQ1q
 e/SI6LMvfIkwUCO3/Wa8qTqwpiEn9lGtWcc9VzeTHsed9ct4Dp0qg03i8ENLNZiOYuppXS3
 ZiDR5ZvJxbjcXUiwqK0mToyPDSNFJiguxIaXWS8y+YN3e8zyjGVErKWEl4V8Q8Zlj94L71v
 hnzH1BLS79HezmS/FRhuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p59SumFpprs=:+LkbvK2TZ5bPPW/pQ57ycF
 KG042IfHbwc7KkexS9WFbMK9ExAb4XlLmIpi4dX782ilxvnR6KUFDPpQv+YTkTSzhBIMFSdVQ
 XPXdJIpjGZ/hsMEgsFZyhzzkFX/GY1kJoKoXzkWtR+eraeXeaFhTSdyJwSPZj3H2epYSnSq1E
 zjUaE9qExDhoVFCbdGKwaiOBrz2h3vL47DxR+DCfUWh4/rBAOclwEJi0d0MIFCas5lTYyDKSG
 4fE/fVQo2JZH7p1vWTjhtgzsKbhp7QUK8KY4ApxhEWmisboUpBJb319hO6HbdjiOFYA9xNEGH
 cWSyRsIhtxEBSN+cLY0e1i0/+MsgqhWwG54eDlnREaSIkppaFu6T6DgoNH4m7hjPP4Jg3XsD5
 4JylB5HsNJ9kvv+z8a0GlsdG7LL2Sy5+dDWlFFFAH1/Y+AwGCJvDKO7I24lScCA3SYfiRLZDg
 61vP+yiNYGZvtiM+JuXFqk8S/jaRSe+djJ7iK0HY4ElLwCERqcnU43CpCEJETSSKWlb6P9qFP
 4QIEbFeaB7wsm1rMJLUzJiHH2lxRQyH4Tj3Pr73aoraUYX+pRFx9USxD8wmgJAHm0hL0ptOVf
 /J/SHCxjvUEwb6/xMVRj8UKFt10O4XgEUKWjRaQWqLcTaGXM1onIyxLfhqkFCFhht1i6BYmvL
 HzB/PhSNM7Rm8yMnBHYKZibOWZ+rCfay/E/mxRtmzDDZQtctMX6A3k/7vdtVtGG/soBvkkKTm
 tg7RCMPpl4KgisQhE7J06WE2bAfVwIHmi6qlNW1CFFMVbospYfkZ9PcsdnBcgfzZHMMkIfPQj
 doiqLJcqSfPpVD0uBel1xSE6T0TfQfNPn/isQkOpnc29STKUXACLihS+NQwwHFqiOB6tbZIX/
 QUajC1d+Y1WVtHT0oeT94ri7yUbcICFJhmgCbrAS+7XEe001AeqnXu7NUG4yvhiZ7z9T/RSMq
 CTfZVSCW63NVtLGpW5ddHx+oBBOqIxySXSEk6RPxSCK3hzarM7HLDrIlL2zyzFEZvwDr6l0BY
 I6Io4W+mXq0Wltlb62S+62kbxK3AmUE80+HAz63dCn3RPOELM+xHWZosQabWterLIFoAIg1cF
 WTpsk2hyc5f5ZnhHjN3xxZojUh9aA+rnsWpuQCdL+ebWEmtu35yDAj9Fwb6oS8XSV3oeRRVpb
 AizB3FlyrWu4+Qg1pPxSowX5p8j+XUXiHPeCL3Mp3YvXWBxKfkHQgE5LzDNc+0Zn0ndnQjzhk
 6RN/8UrtKW8Up6jlr9NsdQssHELKNKedLkFum7A==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tested with these 2 changes below too=2E

Am 12=2E August 2020 14:08:19 MESZ schrieb Philipp Zabel <p=2Ezabel@pengut=
ronix=2Ede>:

>> +	if (!IS_ERR(host->reset)) {
>> +		reset_control_assert(host->reset);
>> +		usleep_range(10, 50);
>> +		reset_control_deassert(host->reset);
>> +	}
>> +
>
>This should be:
>
>	if (host->reset) {
>		reset_control_assert(host->reset);
>		usleep_range(10, 50);
>		reset_control_deassert(host->reset);
>	}
>

>> +	host->reset =3D devm_reset_control_get_optional_exclusive(&pdev->dev,
>> +								"hrst");
>> +	if (PTR_ERR(host->reset) =3D=3D -EPROBE_DEFER)
>> +		return PTR_ERR(host->reset);
>> +
>
>This should be:
>
>	host->reset =3D devm_reset_control_get_optional_exclusive(&pdev->dev,
>								"hrst");
>	if (IS_ERR(host->reset))
>		return PTR_ERR(host->reset);
>

>With these two changes,
>
>Reviewed-by: Philipp Zabel <p=2Ezabel@pengutronix=2Ede>

regards Frank
