From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v6 2/2] mmc: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
Date: Fri, 8 May 2015 13:40:08 +0530
Message-ID: <CAOHikRBLbf5QkBTiMpL_WEPwq4wZdw3BtooyjkbwLd0A+xunGQ@mail.gmail.com>
References: <1430919731-9016-1-git-send-email-stripathi@apm.com>
 <1430919731-9016-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1182211869843661532=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1430919731-9016-3-git-send-email-stripathi@apm.com>
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
To: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Suman Tripathi <stripathi@apm.com>, Jon Masters <jcm@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============1182211869843661532==
Content-Type: multipart/alternative; boundary=f46d043893c57e703205158d8e78

--f46d043893c57e703205158d8e78
Content-Type: text/plain; charset=UTF-8

On Wed, May 6, 2015 at 7:12 PM, Suman Tripathi <stripathi@apm.com> wrote:

> The sdhci framework disables SDR104/SDR50/DDR50 based on only quirk.
> This patch adds the support to disable SDR104/SDR50/DDR50 based on
> reading the capability register 0.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c80287a..e024c64 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3199,7 +3199,8 @@ int sdhci_add_host(struct sdhci_host *host)
>                 }
>         }
>
> -       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
> +       if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V ||
> +           !(caps[0] & SDHCI_CAN_VDD_180))
>                 caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>                        SDHCI_SUPPORT_DDR50);
>
> --
> 1.8.2.1
>
>
Any comments on this patch ??


-- 
Thanks,
with regards,
Suman Tripathi

--f46d043893c57e703205158d8e78
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, May 6, 2015 at 7:12 PM, Suman Tripathi <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:stripathi@apm.com" target=3D"_blank">stripathi@apm.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">The sdhci framework dis=
ables SDR104/SDR50/DDR50 based on only quirk.<br>
This patch adds the support to disable SDR104/SDR50/DDR50 based on<br>
reading the capability register 0.<br>
<br>
Signed-off-by: Suman Tripathi &lt;<a href=3D"mailto:stripathi@apm.com">stri=
pathi@apm.com</a>&gt;<br>
---<br>
=C2=A0drivers/mmc/host/sdhci.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c<br>
index c80287a..e024c64 100644<br>
--- a/drivers/mmc/host/sdhci.c<br>
+++ b/drivers/mmc/host/sdhci.c<br>
@@ -3199,7 +3199,8 @@ int sdhci_add_host(struct sdhci_host *host)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;quirks2 &amp; SDHCI_QUIRK2_NO_1_8_=
V)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;quirks2 &amp; SDHCI_QUIRK2_NO_1_8_=
V ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(caps[0] &amp; SDHCI_CAN_VDD_180=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 caps[1] &amp;=3D ~(=
SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SDHCI_SUPPORT_DDR50);<br>
<br>
--<br>
1.8.2.1<br>
<br>
</blockquote></div><div class=3D"gmail_extra"><br></div>Any comments on thi=
s patch ??<br><br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div>Thanks,</div><div>with regards,</div>Suman =
Tripathi</div></div>
</div></div>

--f46d043893c57e703205158d8e78--

--===============1182211869843661532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============1182211869843661532==--
