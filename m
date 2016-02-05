From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [bug] kernel panic if writting data to mmc after suspendding
Date: Fri, 5 Feb 2016 18:34:23 +0100
Message-ID: <CAPDyKFqf-DEdkBXVd82W1r9t=Kb0y95trGFVLgf5JmQQpvJc=g@mail.gmail.com>
References: <566A21D2.4080009@jinso.co.jp>
	<566E2AC0.8060800@jinso.co.jp>
	<CAMuHMdWU0WVBiWSsLti=KSidFk198k_3CAiNm=iGLtmw4wQOgw@mail.gmail.com>
	<CAPDyKFomFTn7iX2kSXFVqstjEWpezNOB-B_DdFFRBWi9upUrpg@mail.gmail.com>
	<5678C081.5090001@jinso.co.jp>
	<56B2A0C1.9050808@jinso.co.jp>
	<CAPDyKFoWt2Xt1xHsGSfyzxX_kvNVSn5Y1rRbZ8Mc8sWOjhX+bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoWt2Xt1xHsGSfyzxX_kvNVSn5Y1rRbZ8Mc8sWOjhX+bw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "ltsi-dev@lists.linuxfoundation.org" <ltsi-dev@lists.linuxfoundation.org>, =?UTF-8?B?U2ltb24g44GV44KT?= <simon@horms.net>, Geert Uytterhoeven <geert+renesas@glider.be>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, Hisao Munakata <hisao.munakata.vt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 4 February 2016 at 09:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 February 2016 at 01:52, Nguyen Viet Dung <nv-dung@jinso.co.jp> wrote:
>> Hi Ulf
>>
>> I want to test this problem withc your patch.
>> Please sent pacthset for me.
>> I have checked below link but detail of patch haven't.
>
> Sorry for the delay. I haven't been able to rebase my patchset yet.
>
> Give me another couple of days, then I will post a new version.

Hi again,

I did a quick retry in re-basing my patches, but realized that it
requires quite some work.

With a quite small effort I did manage to improve the code in
->probe() and in ->set_ios(), related to runtime PM and clock
management. I will post these patches after the weekend, but
unfortunate I doubt these will fix the problem you reported here.
Although, please help and test them.

To fix the problem properly, one should probable re-write the locking
and the state machine code in the driver, because it's rather messy
and has likely problems.
As a quick fix, one could validate pointers before accessing them in
the sh_mmcif_irqt() function, because that's not done currently.

So to be clear, this is all can help with currently. I wish I could
help more, but I have limited bandwidth and no HW to test on. :-)

Kind regards
Uffe
