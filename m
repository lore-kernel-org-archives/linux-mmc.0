From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
Date: Mon, 1 Jun 2015 13:38:47 +0530
Message-ID: <CAOHikRBB9Uyh4Z34_pFTdmA0A-vnV09zTi8iYEU+01XvmzSr_A@mail.gmail.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
 <1432197817-22110-3-git-send-email-stripathi@apm.com>
 <CAPDyKFpxkNF9C8AOJ6+18CEcpZTKycPR0i5OuwPRr1Zc+VPJ5Q@mail.gmail.com>
 <CAOHikRASDmy7PwFjqmX7JAjW52DYR+d3RkE3yd_45NN5sHK7Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0308162133644622013=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <CAOHikRASDmy7PwFjqmX7JAjW52DYR+d3RkE3yd_45NN5sHK7Pg@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: aisheng.dong@freescale.com
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Langsdorf <mlangsdo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Michal Simek <michal.simek@xilinx.com>, patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============0308162133644622013==
Content-Type: multipart/alternative; boundary=001a11c352a6daeefa0517705509

--001a11c352a6daeefa0517705509
Content-Type: text/plain; charset=UTF-8

Hi Aisheng,

On Wed, May 27, 2015 at 7:46 PM, Suman Tripathi <stripathi@apm.com> wrote:

>
>
> On Tue, May 26, 2015 at 6:06 PM, Ulf Hansson <ulf.hansson@linaro.org>
> wrote:
>
>> On 21 May 2015 at 10:43, Suman Tripathi <stripathi@apm.com> wrote:
>> > The sdhci framework disables SDR104/SDR50/DDR50 based on only quirk.
>> > This patch adds the support to disable SDR104/SDR50/DDR50 based on
>> > reading the capability register 0.
>> >
>> > Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> > ---
>> > ---
>> >  drivers/mmc/host/sdhci.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> > index 58c1770..a3d9b8a 100644
>> > --- a/drivers/mmc/host/sdhci.c
>> > +++ b/drivers/mmc/host/sdhci.c
>> > @@ -3118,7 +3118,8 @@ int sdhci_add_host(struct sdhci_host *host)
>> >                 }
>> >         }
>> >
>> > -       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
>> > +       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V ||
>> > +           !(caps[0] & SDHCI_CAN_VDD_180))
>> >                 caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50
>> |
>> >                        SDHCI_SUPPORT_DDR50);
>> >
>> > --
>> > 1.8.2.1
>> >
>>
>> I have no problem with this patch, except that it would be nice to get
>> a few "tested by" to make sure it doesn't break UHS support for some
>> SoCs.
>>
>> Kind regards
>> Uffe
>>
>
> Can anyone test this in some other SoC ? Appreciate your help ..
>
> Can you test this patch  on imx SoC ?

>
> --
> Thanks,
> with regards,
> Suman Tripathi
>



-- 
Thanks,
with regards,
Suman Tripathi

--001a11c352a6daeefa0517705509
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Aisheng,<br><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Wed, May 27, 2015 at 7:46 PM, Suman Tripathi <span dir=
=3D"ltr">&lt;<a href=3D"mailto:stripathi@apm.com" target=3D"_blank">stripat=
hi@apm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr"><br><div class=3D"gmail_extra"><div><div><br><div class=3D"gmail_q=
uote">On Tue, May 26, 2015 at 6:06 PM, Ulf Hansson <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:ulf.hansson@linaro.org" target=3D"_blank">ulf.hansson@linar=
o.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div>On =
21 May 2015 at 10:43, Suman Tripathi &lt;<a href=3D"mailto:stripathi@apm.co=
m" target=3D"_blank">stripathi@apm.com</a>&gt; wrote:<br>
&gt; The sdhci framework disables SDR104/SDR50/DDR50 based on only quirk.<b=
r>
&gt; This patch adds the support to disable SDR104/SDR50/DDR50 based on<br>
&gt; reading the capability register 0.<br>
&gt;<br>
&gt; Signed-off-by: Suman Tripathi &lt;<a href=3D"mailto:stripathi@apm.com"=
 target=3D"_blank">stripathi@apm.com</a>&gt;<br>
&gt; ---<br>
&gt; ---<br>
&gt;=C2=A0 drivers/mmc/host/sdhci.c | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c<br>
&gt; index 58c1770..a3d9b8a 100644<br>
&gt; --- a/drivers/mmc/host/sdhci.c<br>
&gt; +++ b/drivers/mmc/host/sdhci.c<br>
&gt; @@ -3118,7 +3118,8 @@ int sdhci_add_host(struct sdhci_host *host)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;quirks2 &amp; SDHCI_QUIRK2_NO=
_1_8_V)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;quirks2 &amp; SDHCI_QUIRK2_NO=
_1_8_V ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(caps[0] &amp; SDHCI_CAN_VD=
D_180))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0caps[1] &=
amp;=3D ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 SDHCI_SUPPORT_DDR50);<br>
&gt;<br>
&gt; --<br>
&gt; 1.8.2.1<br>
&gt;<br>
<br>
</div></div>I have no problem with this patch, except that it would be nice=
 to get<br>
a few &quot;tested by&quot; to make sure it doesn&#39;t break UHS support f=
or some<br>
SoCs.<br>
<br>
Kind regards<br>
Uffe<br>
</blockquote></div><div class=3D"gmail_extra"><br></div></div></div>Can any=
one test this in some other SoC ? Appreciate your help ..<span><br><br clea=
r=3D"all"></span></div></div></blockquote><div>Can you test this patch =C2=
=A0on imx SoC ? =C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_extra"><span><div><br></div>-- <br><div><div dir=3D"lt=
r"><div>Thanks,</div><div>with regards,</div>Suman Tripathi</div></div>
</span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div><div di=
r=3D"ltr"><div>Thanks,</div><div>with regards,</div>Suman Tripathi</div></d=
iv>
</div></div>

--001a11c352a6daeefa0517705509--

--===============0308162133644622013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============0308162133644622013==--
