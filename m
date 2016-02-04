From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Subject: Re: [bug] kernel panic if writting data to mmc after suspendding
Date: Thu, 4 Feb 2016 09:52:17 +0900
Message-ID: <56B2A0C1.9050808@jinso.co.jp>
References: <566A21D2.4080009@jinso.co.jp> <566E2AC0.8060800@jinso.co.jp>
 <CAMuHMdWU0WVBiWSsLti=KSidFk198k_3CAiNm=iGLtmw4wQOgw@mail.gmail.com>
 <CAPDyKFomFTn7iX2kSXFVqstjEWpezNOB-B_DdFFRBWi9upUrpg@mail.gmail.com>
 <5678C081.5090001@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5678C081.5090001@jinso.co.jp>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux MMC List <linux-mmc@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "ltsi-dev@lists.linuxfoundation.org" <ltsi-dev@lists.linuxfoundation.org>, =?UTF-8?B?U2ltb24g44GV44KT?= <simon@horms.net>, Geert Uytterhoeven <geert+renesas@glider.be>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, Hisao Munakata <hisao.munakata.vt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf

I want to test this problem withc your patch.
Please sent pacthset for me.
I have checked below link but detail of patch haven't.

Best regard,
Nguyen Viet Dung

On 2015=E5=B9=B412=E6=9C=8822=E6=97=A5 12:16, Nguyen Viet Dung wrote:
> Hi Geert
>
> Thank for your reply.
>
> On 2015=E5=B9=B412=E6=9C=8818=E6=97=A5 19:27, Ulf Hansson wrote:
>> On 18 December 2015 at 10:33, Geert Uytterhoeven=20
>> <geert@linux-m68k.org> wrote:
>>> Hi Dung-san,
>>>
>>> CC Ulf
>>>
>>> On Mon, Dec 14, 2015 at 3:34 AM, Nguyen Viet Dung=20
>>> <nv-dung@jinso.co.jp> wrote:
>>>> While is testting LTSI-v4.1.13-rc1, we have found the following th=
e=20
>>>> failure
>>>> of mmcif.
>>>> 1. mount mmc block
>>>> 2. write data to mmc block
>>>> 3. suspend/resume
>>>> 4. write data to mmc block one again =3D> happen kernel panic
>>>> (Probability in this test procedure is 100%)
>>>>
>>>> We have used git bisect to find cause of failure in LTS-v4.1.13 to
>>>> LTSI-v4.1.13-rc1
>>>> and have found commit which cause failure.
>>>> (On LTS-v4.1.13 has not this failure)
>>>>   drivers: sh: Disable PM runtime for multi-platform ARM with genp=
d
>>>>   commit :cbc41d0a761bffb3166a413a3c77100a737c0cd7
>>> That means there's a bug in Runtime PM handling of the sh_mmcif=20
>>> driver, or
>>> in the MMC subsystem.
>>>
>>> Usually such bugs cause a kernel hang on register access, not a NUL=
L=20
>>> pointer
>>> dereference, though.
>> Agree!
>>
>> I doubt the bisected commit is where the *real* issue is. Looking in=
to
>> the details for how system PM and runtime PM is deployed in sh_mmcif=
,
>> I believe some improvements are needed.
>>
>> Actually, I made an attempt to modernize the PM code for sh_mmcif a=20
>> while ago.
>> http://marc.info/?l=3Dlinux-mmc&m=3D138245085523815&w=3D2
>>
>> Whether that fixes the problem reported here, I have no idea. Althou=
gh
>> if not, it should move the code to a position where it becomes easie=
r
>> to properly fix this issue.
>>
>> I am willing to help and rebase that patchset, but I require help in
>> testing since I haven't been able to get a hold of a HW. Can I count
>> on that?
> Yes , I can help you test.
> If you have rebased patchset, phease tell me.
>
> Best regards,
> Nguyen Viet Dung

