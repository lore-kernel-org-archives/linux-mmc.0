From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into the
 driver
Date: Fri, 14 Dec 2012 16:52:30 +0100
Message-ID: <CAPDyKFogripZun48OFL4RfGh+sJD4037+kZe068CM86O8jhVYQ@mail.gmail.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
 <20121214151002.GK14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7235763428128519286=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121214151002.GK14363@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============7235763428128519286==
Content-Type: multipart/alternative; boundary=f46d04463040eaf68604d0d204ee

--f46d04463040eaf68604d0d204ee
Content-Type: text/plain; charset=ISO-8859-1

On Friday, 14 December 2012, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:
> On Fri, Dec 14, 2012 at 03:30:29PM +0100, Ulf Hansson wrote:
>> From: Lee Jones <lee.jones@linaro.org>
>>
>> There are currently two instances of the ios_handler being used.
>> Both of which mearly toy with some regulator settings. Now there
>> is a GPIO regulator API, we can use that instead, and lessen the
>> per platform burden. By doing this, we also become more Device
>> Tree compatible.
>
> Err, why is this needed?  What's wrong with using the 'vmmc' for this?

This is not for power to the card, but for the I/O voltage. Before this was
controlled by the ios_handler.

>
> From what I read in the mmc core, vmmc handling via
mmc_regulator_set_ocr()
> can cope with GPIO-based regulators, and if you have a single GPIO signal
> then you have a single supply (it's either on or off).  So what's wrong
> with using the existing regulator hooks for this which are already there?

Kind regards
Ulf Hansson

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--f46d04463040eaf68604d0d204ee
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, 14 December 2012, Russell King - ARM Linux &lt;<a href=
=3D"mailto:linux@arm.linux.org.uk">linux@arm.linux.org.uk</a>&gt; wrote:<br=
>&gt; On Fri, Dec 14, 2012 at 03:30:29PM +0100, Ulf Hansson wrote:<br>&gt;&=
gt; From: Lee Jones &lt;<a href=3D"mailto:lee.jones@linaro.org">lee.jones@l=
inaro.org</a>&gt;<br>
&gt;&gt;<br>&gt;&gt; There are currently two instances of the ios_handler b=
eing used.<br>&gt;&gt; Both of which mearly toy with some regulator setting=
s. Now there<br>&gt;&gt; is a GPIO regulator API, we can use that instead, =
and lessen the<br>
&gt;&gt; per platform burden. By doing this, we also become more Device<br>=
&gt;&gt; Tree compatible.<br>&gt;<br>&gt; Err, why is this needed? =A0What&=
#39;s wrong with using the &#39;vmmc&#39; for this?<br><br>This is not for =
power to the card, but for the I/O voltage. Before this was controlled by t=
he ios_handler.<br>
<br>&gt;<br>&gt; From what I read in the mmc core, vmmc handling via mmc_re=
gulator_set_ocr()<br>&gt; can cope with GPIO-based regulators, and if you h=
ave a single GPIO signal<br>&gt; then you have a single supply (it&#39;s ei=
ther on or off). =A0So what&#39;s wrong<br>
&gt; with using the existing regulator hooks for this which are already the=
re?<br><br>Kind regards<br>Ulf Hansson<br><br>&gt; --<br>&gt; To unsubscrib=
e from this list: send the line &quot;unsubscribe linux-mmc&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>&gt; More majordomo info at =A0<a href=3D"=
http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordom=
o-info.html</a><br>
&gt;

--f46d04463040eaf68604d0d204ee--


--===============7235763428128519286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7235763428128519286==--
