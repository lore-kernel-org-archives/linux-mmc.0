From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 0/6] mmc: Field Firmware Update
Date: Thu, 14 Jan 2016 13:50:58 +0100
Message-ID: <CAPDyKFqiMbstjkbzxiz50MvpFc4u1kQtMSSsFv-GYLE6mmBzLg@mail.gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
	<SN1PR02MB13891415516DE9FA4756140783070@SN1PR02MB1389.namprd02.prod.outlook.com>
	<CAOpc7mHbM8EYYNRKR+pKnzc0wf1DR1ojX-iFuDWDYyquC3EVZg@mail.gmail.com>
	<CAPDyKFp2WEVF4yi=Upzx+58SY15u=Fp4=tr3_hh7AS3T2yz4qQ@mail.gmail.com>
	<87r3ierjae.fsf@gmail.com>
	<CAPDyKFpgYLDRt8=mayqB8sqD0ArXnv31a+fTZAnT_4Vf7yuFwQ@mail.gmail.com>
	<CAPDyKFq5wNARNpDMK0_TJ3P64UAsCr_L42sj+JA-k6DdoFBJsw@mail.gmail.com>
	<CALiw-2Eisj-WDB3hcsB22MTzHDS7y+V3gvTvq_+Jt8PKMa5GMg@mail.gmail.com>
	<CAG=SpYGf7czPwLrJVrq49n_Lhph33fmyKq-Nkm6=c0fB1Gn9_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36640 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbcANMu7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2016 07:50:59 -0500
Received: by mail-qk0-f177.google.com with SMTP id q19so240312560qke.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2016 04:50:59 -0800 (PST)
In-Reply-To: <CAG=SpYGf7czPwLrJVrq49n_Lhph33fmyKq-Nkm6=c0fB1Gn9_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Holger Schurig <holgerschurig@gmail.com>, Olof Johansson <olofj@chromium.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Baolin Wang <baolin.wang@linaro.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>, Seshagiri Holi <sholi@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>

On 22 December 2015 at 19:51, Chris Ball <chris@printf.net> wrote:
> Hi,
>
>> Chris has been busy with other stuff the last couple of years, is there a
>> lot of mmc-utils code that's out there that hasn't been picked up?

I don't really know.

Although, I wanted to make sure that the tool still was still being
maintained as otherwise people sooner or later will not care to send
patches.

>
> I've been applying mmc-utils patches as I get them -- last push was five
> weeks ago.  So I don't have a backlog, but if people are sending mmc-utils
> patches to lists rather than to me directly, I'm unlikely to see them there.
>

I haven't bothered much at looking at mmc utils patches, although I
have noticed some being posted without any response or being picked
up.
I browsed the history of these patches and noticed that it's exactly
as you say. These haven't been sent directly you or they were sent to
an incorrect email address.

I apologize if I was giving the wrong impression that you didn't
maintain mmc utils very well, you certainly are!

Perhaps we should add some information about it in the mmc kernel doc,
to make it more visible.

Kind regards
Uffe
