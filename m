From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: SDHCI Auto-CMD23 fixes.
Date: Wed, 25 May 2011 15:35:39 -0500
Message-ID: <BANLkTikK2-R91nJmes2EYvR0z=Sj_QTjJg@mail.gmail.com>
References: <m3aaeby3xr.fsf@pullcord.laptop.org>
	<1306307623-8610-1-git-send-email-andreiw@motorola.com>
	<m3d3j6r11r.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:33435 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab1EYUfl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 16:35:41 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4PKXGLd013306
	for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 16:33:16 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4PKV79O012164
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 16:33:16 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so31397wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 13:35:39 -0700 (PDT)
In-Reply-To: <m3d3j6r11r.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, May 25, 2011 at 3:13 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, May 25 2011, Andrei Warkentin wrote:
>> Fixes bugs in Auto-CMD23 feature enable decision. Auto-CMD23
>> shoud be enabled if host is >=3D v3, and SDMA is not in use.
>>
>> USE_ADMA | USE_SDMA | Auto-CMD23
>> ---------+----------+-----------
>> =A0 =A0 0 =A0 =A0| =A0 =A00 =A0 =A0 | =A0 =A0 1
>> ---------+----------+-----------
>> =A0 =A0 0 =A0 =A0| =A0 =A01 =A0 =A0 | =A0 =A0 0
>> ---------+----------+-----------
>> =A0 =A0 1 =A0 =A0| =A0 =A00 =A0 =A0 | =A0 =A0 1
>> ---------+----------+-----------
>> =A0 =A0 1 =A0 =A0| =A0 =A01 =A0 =A0 | =A0 =A0 1
>>
>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
>
> Great, this does the right thing on my XO now. =A0I'll send it to Lin=
us
> along with the rest of the merge shortly.
>
> Thanks!
>

Great :-)! Thanks!

A
