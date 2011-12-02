From: Sangwook Lee <sangwook.lee@linaro.org>
Subject: Re: Build breakage in sdhci-s3c
Date: Fri, 2 Dec 2011 13:11:53 +0000
Message-ID: <CADPsn1b-_3bT41RRm4X3YFoH1pax6yA_XPsA8LBiN0GunLb80Q@mail.gmail.com>
References: <20111202115807.GJ8245@opensource.wolfsonmicro.com>
	<CADPsn1aRwUfP+TjDXisoFqJUxg+H7m+OE3GVBE3PF1JZq-_PfA@mail.gmail.com>
	<20111202130412.GP8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57084 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095Ab1LBNLz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 08:11:55 -0500
Received: by ggnr5 with SMTP id r5so2907367ggn.19
        for <linux-mmc@vger.kernel.org>; Fri, 02 Dec 2011 05:11:55 -0800 (PST)
In-Reply-To: <20111202130412.GP8245@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Thomas Abraham <thomas.abraham@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

+Thomas


On 2 December 2011 13:04, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Dec 02, 2011 at 12:59:42PM +0000, Sangwook Lee wrote:
>
>> and I found out that the following patch wasn't applied This =A0patc=
h
>> was acked by you and Thomas.
>
>> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/7832
>> This patch has the title : [PATCH v2 1/2] ARM: SAMSUNG: Add pm_caps
>> into platform data
>
>> Could you help me to solve the below problem ?
>
> Probably the simplest/best solution here is for Chris to apply this
> patch with Kukjin and Thomas' acks to the mmc tree.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
