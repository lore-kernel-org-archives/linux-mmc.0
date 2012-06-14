From: haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: Re: [PATCH] mmc: sdhci-pxa: Add device tree support
Date: Thu, 14 Jun 2012 02:15:23 +0000
Message-ID: <e89a8ff1c3b8b41f0104c26545d9@google.com>
References: <87sjdzxpqr.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3627717907685580079=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87sjdzxpqr.fsf-DGHOrqG7t0YzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Philip Rakity <prakity-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhangfei Gao <zhangfei.gao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============3627717907685580079==
Content-Type: multipart/alternative; boundary=e89a8ff1c3b8b41ef304c26545d6

--e89a8ff1c3b8b41ef304c26545d6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes

On , Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> wrote:
> Hi Zhangfei,



> On Tue, Jun 12 2012, zhangfei gao wrote:

> > On Wed, Jun 13, 2012 at 3:05 AM, Chris Ball cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> wrote:


> How do you feel about having the compatible node say "sdhci-pxav3"
> instead of "mrvl,pxav3-mmc"? I used the mrvl prefix because it fits
> in with the rest of your existing DT, but it seems like it would be
> better to name the driver directly. The DTs here live inside the
> source tree, so we're not depending on anyone else's terminology.

> If you're okay with sdhci-pxav{2,3} in compatible, I'll include that
> in v2 of the patch with the rest of your fixes.

Compatible node could be "mrvl,pxav3-mmc" or "mrvl,sdhci-pxav3". It's
depend on your choice. I prefer to use vendor name in compatible property.
And we could avoid naming conflict.

+ if (of_find_property(np, "non-removable", NULL))
+ pdata->flags |= PXA_FLAG_CARD_PERMANENT;
+
+ of_property_read_u32(np, "bus-width", &bus_width);
+ if (bus_width == 8)
+ pdata->flags |= PXA_FLAG_SD_8_BIT_CAPABLE_SLOT;
+
+ of_property_read_u32(np, "clk-delay-cycles", &clk_delay_cycles);
+ if (clk_delay_cycles > 0)
+ pdata->clk_delay_cycles = clk_delay_cycles;
+

These properties should be "mrvl,non-removable", "mrvl,bus-width",
"mrvl,clk-delay-cycles". Since it's mentioned in
Documentations/devicetree/booting-without-of.txt. "It is recommended
that if you add any "custom" property whose name may clash with
standard defined ones, you prefix them with your vendor name and
a comma."

--e89a8ff1c3b8b41ef304c26545d6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On , Chris Ball &lt;cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org&gt; wrote:<br />&gt; Hi Zhangfei,<br />&=
gt; <br />&gt; <br />&gt; <br />&gt; On Tue, Jun 12 2012, zhangfei gao wrot=
e:<br />&gt; <br />&gt; &gt; On Wed, Jun 13, 2012 at 3:05 AM, Chris Ball cj=
b@laptop.org&gt; wrote:<br />&gt; <br />&gt; <br />&gt; How do you feel abo=
ut having the compatible node say &quot;sdhci-pxav3&quot;<br />&gt; instead=
 of &quot;mrvl,pxav3-mmc&quot;? =A0I used the mrvl prefix because it fits<b=
r />&gt; in with the rest of your existing DT, but it seems like it would b=
e<br />&gt; better to name the driver directly. =A0The DTs here live inside=
 the<br />&gt; source tree, so we&#39;re not depending on anyone else&#39;s=
 terminology.<br />&gt; <br />&gt; If you&#39;re okay with sdhci-pxav{2,3} =
in compatible, I&#39;ll include that<br />&gt; in v2 of the patch with the =
rest of your fixes.<br />&gt; <br />Compatible node could be &quot;mrvl,pxa=
v3-mmc&quot; or &quot;mrvl,sdhci-pxav3&quot;. It&#39;s <br />depend on your=
 choice. I prefer to use vendor name in compatible property.<br />And we co=
uld avoid naming conflict.<br /><br />+       if (of_find_property(np, &quo=
t;non-removable&quot;, NULL))<br />+               pdata-&gt;flags |=3D PXA=
_FLAG_CARD_PERMANENT;<br />+<br />+       of_property_read_u32(np, &quot;bu=
s-width&quot;, &bus_width);<br />+       if (bus_width =3D=3D 8)<br />+    =
           pdata-&gt;flags |=3D PXA_FLAG_SD_8_BIT_CAPABLE_SLOT;<br />+<br /=
>+       of_property_read_u32(np, &quot;clk-delay-cycles&quot;, &clk_delay_=
cycles);<br />+       if (clk_delay_cycles &gt; 0)<br />+               pda=
ta-&gt;clk_delay_cycles =3D clk_delay_cycles;<br />+<br /><br />These prope=
rties should be &quot;mrvl,non-removable&quot;, &quot;mrvl,bus-width&quot;,=
 <br />&quot;mrvl,clk-delay-cycles&quot;.  Since it&#39;s mentioned in <br =
/>Documentations/devicetree/booting-without-of.txt. &quot;It is recommended=
 <br />that if you add any &quot;custom&quot; property whose name may clash=
 with <br />standard defined ones, you prefix them with your vendor name an=
d <br />a comma.&quot;
--e89a8ff1c3b8b41ef304c26545d6--

--===============3627717907685580079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3627717907685580079==--
