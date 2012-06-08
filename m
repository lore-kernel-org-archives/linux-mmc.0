From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: power class selection fails on 3.5-rc1
Date: Fri, 8 Jun 2012 18:57:02 +0530
Message-ID: <000301cd457a$66326dc0$32974940$@codeaurora.org>
References: <6008680.IROCjD91iZ@ax5200p>	<4FCDFD3E.9020804@stericsson.com>	<000301cd43c9$05745550$105cfff0$@codeaurora.org>	<1577823.5RM6MKofop@ax5200p>	<000701cd4497$9035d550$b0a17ff0$@codeaurora.org> <CAGxe1ZGLfETh5N2YkSOhe0OhpD_pjro=C00SwXrdVhq7AKAEYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:61232 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab2FHN1I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jun 2012 09:27:08 -0400
In-Reply-To: <CAGxe1ZGLfETh5N2YkSOhe0OhpD_pjro=C00SwXrdVhq7AKAEYA@mail.gmail.com>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>
Cc: 'Marc Dietrich' <marvin24@gmx.de>, 'Ulf Hansson' <ulf.hansson@stericsson.com>, saugata.das@linaro.org, linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Girish K S [mailto:girish.shivananjappa@linaro.org]
> Sent: Friday, June 08, 2012 5:16 PM
> To: Subhash Jadavani
> Cc: Marc Dietrich; Ulf Hansson; saugata.das@linaro.org; linux-
> mmc@vger.kernel.org
> Subject: Re: power class selection fails on 3.5-rc1
>=20
> On 7 June 2012 15:53, Subhash Jadavani <subhashj@codeaurora.org> wrot=
e:
> >> > Just for experiment, can we hack the value set to POWER_CLASS fi=
eld
> >> > to
> >> > 0x7 instead of 0x3? If this doesn't work, you may try other valu=
es
> >> > (starting from 1 till 15) to see setting any of the non-zero val=
ue
> > succeeds or
> >> not.
> >>
> >> I tried 1 to 10 (as this is a 4.41 card) and none of them worked
> > (including 7).
> >
> > Oh, that's not good.
> >
> > Girish / Saugata,
> > Do you have any comments on this? Can you please comment on what ty=
pe
> > of testing was done when we had initially added this power class
selection?
> Today i tried om the eMMC 4.5 sample.

Thanks Girish for trying this out. Does this particular eMMC4.5 sample =
is
supporting HS200? If yes, then can you please undefine MMC_CAP2_HS200 a=
nd
try? I guess Marc's card don't support HS200 so it will take different =
code
path then yours. In HS200 case, device bus width is first selected and =
then
power class selection field is written. Where as in Marc's case, if car=
d
doesn't support HS200, first power class is selected and then card bus =
width
would be changed.

Regards,
Subhash

> I forced the values from 1- 10
> I was able to successfully set the power class value without any erro=
r
return
> value. It failed for the for the value 0xf.



> >
> > Regards,
> > Subhash
> >
> >> -----Original Message-----
> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> >> owner@vger.kernel.org] On Behalf Of Marc Dietrich
> >> Sent: Thursday, June 07, 2012 3:05 PM
> >> To: Subhash Jadavani
> >> Cc: 'Ulf Hansson'; Girish K S; saugata.das@linaro.org; linux-
> >> mmc@vger.kernel.org
> >> Subject: Re: power class selection fails on 3.5-rc1
> >>
> >> On Wednesday 06 June 2012 15:14:48 Subhash Jadavani wrote:
> >> > > On 06/04/2012 06:35 PM, Marc Dietrich wrote:
> >> > > > Hi,
> >> > > >
> >> > > > somehow I hope this would go away by itself, but it didn't :=
-(
> >> > > > I reported this problem some time ago (see:
> >> > > > http://www.mail-archive.com/linux-
> >> > > > mmc@vger.kernel.org/msg13688.html ) but got no clear answer =
or
fix.
> >> > > >
> >> > > > In addition to the information I posted on the thread above,=
 I
> >> > > > also dumped the contents of the ext_csd register file (where
> >> > > > reg values are not zero):
> >> > > >
> >> > > > reg =A0 =A0 =A0 Sandisk =A0 =A0 =A0 =A0 Toshiba
> >> > > > 241 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A050 =A0 =A0 =A00x32
> >> > > > 239 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A051 =A0 =A0 =A00x33
> >> > > > 238 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A0119 =A0 =A0 0x77
> >> > > > 234 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A030 =A0 =A0 =A00x1e
> >> > > > 232 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A04 =A0 =A0 =A0 0x04
> >> > > > 231 =A0 =A0 21 =A0 =A0 =A00x15 =A0 =A021 =A0 =A0 =A00x15
> >> > > > 230 =A0 =A0 150 =A0 =A0 0x96 =A0 =A016 =A0 =A0 =A00x10
> >> > > > 229 =A0 =A0 150 =A0 =A0 0x96 =A0 =A066 =A0 =A0 =A00x42
> >> > > > 228 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A07 =A0 =A0 =A0 0x07
> >> > > > 226 =A0 =A0 8 =A0 =A0 =A0 0x08 =A0 =A016 =A0 =A0 =A00x10
> >> > > > 225 =A0 =A0 6 =A0 =A0 =A0 0x06 =A0 =A07 =A0 =A0 =A0 0x07
> >> > > > 224 =A0 =A0 4 =A0 =A0 =A0 0x04 =A0 =A08 =A0 =A0 =A0 0x08
> >> > > > 223 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A02 =A0 =A0 =A0 0x02
> >> > > > 222 =A0 =A0 8 =A0 =A0 =A0 0x08 =A0 =A016 =A0 =A0 =A00x10
> >> > > > 221 =A0 =A0 16 =A0 =A0 =A00x10 =A0 =A01 =A0 =A0 =A0 0x01
> >> > > > 220 =A0 =A0 8 =A0 =A0 =A0 0x08 =A0 =A07 =A0 =A0 =A0 0x07
> >> > > > 219 =A0 =A0 7 =A0 =A0 =A0 0x07 =A0 =A07 =A0 =A0 =A0 0x07
> >> > > > 217 =A0 =A0 16 =A0 =A0 =A00x10 =A0 =A017 =A0 =A0 =A00x11
> >> > > > 215 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A00 =A0 =A0 =A0 0x00
> >> > > > 214 =A0 =A0 218 =A0 =A0 0xda =A0 =A0238 =A0 =A0 0xee
> >> > > > 213 =A0 =A0 160 =A0 =A0 0xa0 =A0 =A0128 =A0 =A0 0x80
> >> > > > 210 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A00 =A0 =A0 =A0 0x00
> >> > > > 209 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A060 =A0 =A0 =A00x3c
> >> > > > 208 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A00 =A0 =A0 =A0 0x00
> >> > > > 207 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A060 =A0 =A0 =A00x3c
> >> > > > 206 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A00 =A0 =A0 =A0 0x00
> >> > > > 205 =A0 =A0 10 =A0 =A0 =A00x0a =A0 =A030 =A0 =A0 =A00x1e
> >> > > > 203 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A051 =A0 =A0 =A00x33
> >> > > > 202 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A051 =A0 =A0 =A00x33
> >> > > > 201 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A0119 =A0 =A0 0x77
> >> > > > 200 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A0119 =A0 =A0 0x77
> >> > > > 196 =A0 =A0 3 =A0 =A0 =A0 0x03 =A0 =A07 =A0 =A0 =A0 0x07
> >> > > > 194 =A0 =A0 2 =A0 =A0 =A0 0x02 =A0 =A02 =A0 =A0 =A0 0x02
> >> > > > 192 =A0 =A0 5 =A0 =A0 =A0 0x05 =A0 =A05 =A0 =A0 =A0 0x05
> >> > > > 185 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A01 =A0 =A0 =A0 0x01
> >> > > > 181 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A01 =A0 =A0 =A0 0x01
> >> > > > 179 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A01 =A0 =A0 =A0 0x01
> >> > > > 175 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A01 =A0 =A0 =A0 0x01
> >> > > > 169 =A0 =A0 1 =A0 =A0 =A0 0x01 =A0 =A00 =A0 =A0 =A0 0x00
> >> > > > 168 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A02 =A0 =A0 =A0 0x02
> >> > > > 160 =A0 =A0 3 =A0 =A0 =A0 0x03 =A0 =A03 =A0 =A0 =A0 0x03
> >> > > > 158 =A0 =A0 0 =A0 =A0 =A0 0x00 =A0 =A03 =A0 =A0 =A0 0x03
> >> > > > 157 =A0 =A0 237 =A0 =A0 0xed =A0 =A0186 =A0 =A0 0xba
> >> > > >
> >> > > > The second and the third column is from a device with a Sand=
isk
> >> > > > eMCC which works fine, while the last two columns are from a
> >> > > > Toshiba eMMC which shows the error. Looking into it, I found
> >> > > > that only the Toshiba eMMC specifies a powerclass in registe=
rs
> >> > > > 203-200 while Sandisk does not, so the powerclass is not
> >> > > > changed in the latter case and the problem cannot be trigger=
ed
there.
> >> > > >
> >> > > > I also attached a boot log with mmc debug enabled. I think
> >> > > > there is not much I can do else. Either this eMMC is just bo=
gus
> >> > > > and needs blacklisting or there is some problem in the drive=
r
code.
> >> >
> >> > I checked the power class specification and MMC core driver
> >> > handing, I don't see any issue with it. As you mentioned the
> >> > PWR_CL_* fields are having non-zero values which means SWITCH
> >> > (CMD6) will be sent to change the POWER_CLASS and from the logs =
you
> >> > have attached, this switch command tries to set the POWER_CLASS =
to
> >> > 3 which is resulting in SWITCH_ERROR in card and that's why it f=
ails.
> >> >
> >> > If the PWR_CL_* fields are 0s (that's the case with SanDisk eMMC=
 as
> >> > you mentioned), SWITCH(cmd6) is not sent to the card.
> >> >
> >> > I was trying to check analyze more from logs and the above EXT_C=
SD
> >> > fields for Toshiba card.
> >> >
> >> > EXT_CSD[203] =3D> PWR_CL_26_360 =3D> 0x33 EXT_CSD[202] =3D>
> PWR_CL_52_360
> >> > =3D> 0x33 EXT_CSD[201] =3D> PWR_CL_26_195 =3D> 0x77 EXT_CSD[200]=
 =3D>
> >> > PWR_CL_52_195 =3D> 0x77
> >> >
> >> > >> [ =A0 =A03.842382] mmc1: clock 48000000Hz busmode 2 powermode=
 2 cs 0
> >> > >> Vdd
> >> 20
> >> >
> >> > width 0 timing 1
> >> > Logs shows that clock =3D 48MHz, bus_width =3D 8-Bit, SDR mode, =
VDD =3D
> >> > High voltage range. This would mean power class for this
> >> > configuration will be in higher nibble of PWR_CL_52_360 field
> (EXT_CSD[202]) which is 0x3.
> >> >
> >> > >> [ =A0 =A03.842390] mmc1: starting CMD6 arg 03bb0301 flags 000=
0049d
> >> >
> >> > "arg" field from this logs show that we are trying to set the
> >> > POWER_CLASS
> >> > (EXT_CSD[187]) field to value 0x3 which is resulting in switch
> >> > error which ideally shouldn't.
> >> >
> >> > Just for experiment, can we hack the value set to POWER_CLASS fi=
eld
> >> > to
> >> > 0x7 instead of 0x3? If this doesn't work, you may try other valu=
es
> >> > (starting from 1 till 15) to see setting any of the non-zero val=
ue
> > succeeds or
> >> not.
> >>
> >> I tried 1 to 10 (as this is a 4.41 card) and none of them worked
> > (including 7).
> >>
> >> > > > I hope this problem can be fixed or if it can't, I hope that
> >> > > > commit 3d93576e (mmc: core: skip card initialization if powe=
r
> >> > > > class selection
> >> > > > fails) is reverted until the issues are sorted out.
> >> >
> >> > 3d93576e is really not the issue here. Reverting that patch is j=
ust
> >> > a bad workaround to the problem. We should actually try to find =
why
> >> > exactly setting the POWER_CLASS field is failing?
> >>
> >> sure, that would be the best solution...
> >>
> >> Marc
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c"
> >> in
> > the body
> >> of a message to majordomo@vger.kernel.org More majordomo info at
> >> http://vger.kernel.org/majordomo-info.html
> >

