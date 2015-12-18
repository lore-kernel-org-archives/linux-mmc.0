From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [bug] kernel panic if writting data to mmc after suspendding
Date: Fri, 18 Dec 2015 11:27:10 +0100
Message-ID: <CAPDyKFomFTn7iX2kSXFVqstjEWpezNOB-B_DdFFRBWi9upUrpg@mail.gmail.com>
References: <566A21D2.4080009@jinso.co.jp>
	<566E2AC0.8060800@jinso.co.jp>
	<CAMuHMdWU0WVBiWSsLti=KSidFk198k_3CAiNm=iGLtmw4wQOgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWU0WVBiWSsLti=KSidFk198k_3CAiNm=iGLtmw4wQOgw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Nguyen Viet Dung <nv-dung@jinso.co.jp>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, "ltsi-dev@lists.linuxfoundation.org" <ltsi-dev@lists.linuxfoundation.org>, =?UTF-8?B?U2ltb24g44GV44KT?= <simon@horms.net>, Geert Uytterhoeven <geert+renesas@glider.be>, =?UTF-8?B?U+mWizEyL+WdguaIuFND?= <ryusuke.sakato.bx@renesas.com>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?B?TWFnbnVzIOOBleOCkw==?= <magnus.damm@gmail.com>, Hisao Munakata <hisao.munakata.vt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 18 December 2015 at 10:33, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Dung-san,
>
> CC Ulf
>
> On Mon, Dec 14, 2015 at 3:34 AM, Nguyen Viet Dung <nv-dung@jinso.co.jp> wrote:
>> While is testting LTSI-v4.1.13-rc1, we have found the following the failure
>> of mmcif.
>> 1. mount mmc block
>> 2. write data to mmc block
>> 3. suspend/resume
>> 4. write data to mmc block one again => happen kernel panic
>> (Probability in this test procedure is 100%)
>>
>> We have used git bisect to find cause of failure in LTS-v4.1.13 to
>> LTSI-v4.1.13-rc1
>> and have found commit which cause failure.
>> (On LTS-v4.1.13 has not this failure)
>>  drivers: sh: Disable PM runtime for multi-platform ARM with genpd
>>  commit :cbc41d0a761bffb3166a413a3c77100a737c0cd7
>
> That means there's a bug in Runtime PM handling of the sh_mmcif driver, or
> in the MMC subsystem.
>
> Usually such bugs cause a kernel hang on register access, not a NULL pointer
> dereference, though.

Agree!

I doubt the bisected commit is where the *real* issue is. Looking into
the details for how system PM and runtime PM is deployed in sh_mmcif,
I believe some improvements are needed.

Actually, I made an attempt to modernize the PM code for sh_mmcif a while ago.
http://marc.info/?l=linux-mmc&m=138245085523815&w=2

Whether that fixes the problem reported here, I have no idea. Although
if not, it should move the code to a position where it becomes easier
to properly fix this issue.

I am willing to help and rebase that patchset, but I require help in
testing since I haven't been able to get a hold of a HW. Can I count
on that?

Kind regards
Uffe
