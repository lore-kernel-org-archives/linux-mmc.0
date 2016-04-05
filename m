From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v3 0/5] davinci_mmc fixes
Date: Tue, 5 Apr 2016 12:07:43 -0500
Message-ID: <5703F0DF.3020209@lechnology.com>
References: <1458186341-6970-1-git-send-email-david@lechnology.com>
 <CAPDyKFp3UELfw2gNTh0GeX31bjwb8tbDiua6ZigLwhaUkcv3zA@mail.gmail.com>
 <5703ECFE.6060706@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:55447 "EHLO vern.gendns.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbcDERHf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Apr 2016 13:07:35 -0400
In-Reply-To: <5703ECFE.6060706@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 04/05/2016 11:51 AM, David Lechner wrote:
> On 04/05/2016 06:12 AM, Ulf Hansson wrote:
>>
>> Patch 3 triggers a compiler warning, please fix it.
>>
>> ../drivers/mmc/host/davinci_mmc.c: In function =E2=80=98davinci_mmcs=
d_probe=E2=80=99:
>> ../drivers/mmc/host/davinci_mmc.c:1208:6: warning: =E2=80=98ret=E2=80=
=99 may be used
>> uninitialized in this function [-Wmaybe-uninitialized]
>>
>> I have applied patch 1->2 for next, so no need to resend these.
>>
>> Kind regards
>> Uffe
>>
>
> I am not getting a compiler warning with this commit. Can you please
> provide a git link so that I can be sure I am building using the same
> branch that you are using?


I think I figured it out. I am applying the patches on top of the next=20
branch from git://git.linaro.org/people/ulf.hansson/mmc.git. However, I=
=20
am still not getting a compiler warning. Perhaps it has to do with the=20
gcc version. I'm not exactly sure how to fix it since it is really not=20
used uninitialized. Just set it to 0 in the variable declaration?
