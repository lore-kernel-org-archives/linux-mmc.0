From: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: add AM33XX MMC support
Date: Fri, 14 Jun 2013 18:43:51 -0500
Message-ID: <CAD=GYpYfMAZeV1RUC=DqhYGZaKiiukpTZg7bhO582eKwimS9aA@mail.gmail.com>
References: <41fde401c8e646689123d7c6d3a2dffc@DLEE71.ent.ti.com>
 <20130307141235.GQ6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20C57@DBDE01.ent.ti.com>
 <20130307144656.GR6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20CCA@DBDE01.ent.ti.com>
 <20130307150408.GU6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20D27@DBDE01.ent.ti.com>
 <20130307160236.GV6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC213C8@DBDE01.ent.ti.com>
 <CAD=GYpb3+nvoz863+VKO7iJijRHnM5RzsVj-5VJfQ-OHoUy19Q@mail.gmail.com>
 <20130614222537.GA25428@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3792420093623824256=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130614222537.GA25428-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
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
To: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============3792420093623824256==
Content-Type: multipart/alternative; boundary=001a11c339d2ace27b04df25d1f9

--001a11c339d2ace27b04df25d1f9
Content-Type: text/plain; charset=ISO-8859-1

Felipe,

On Friday, June 14, 2013, Felipe Balbi wrote:

> Hi,
>
> On Fri, Jun 14, 2013 at 02:54:33PM -0500, Joel A Fernandes wrote:
> > Hi Tony, Vaibhav,
> >
> > >> I just doublechecked MMC rootfs on bone and evmsk as it's the standard
> > >> smoke test. My EVM is intermittent now so trying to coax it to power
> up
> > >> to reverify.
> > >>
> > >
> > > Matt,
> > >
> > > Your branch is working for me, I tested it on EVM. Not sure what is
> wrong with manual rebasing
> > > I did yesterday. I will try to nail-down root-cause here.
> > >
> > > And you can submit the next version fixing the comments I have given.
> >
> > The only comment I could find in the whole discussion was adding of
> > the interrupts property. I tested I don't have any problem booting
> > with Matt's patch, without having the interrupts property.
>
> might very well be, but we want to figure out why adding "intrrupts"
> causes issues. Why does it have to come through hwmod ? You might have
> uncovered a real problem which needs fixing. Besides, at the end of the


No actually I think I wasn't very descriptive in my post. There is no
problem here. Whether it comes from DT or not, it works in both cases . (I
haven't tried adding interrupt node to dts but what I gathered from
Vaibhav's post is that it works also when added to dts)

But I can revisit Vaibhav's suggestion of adding it to dts for completeness
sake. My tree currently works and picks up the interrupt info from hwmod. I
just didn't see any activity on this thread for a while so I thought of
enquiring it was ok to pull it in for the 3.11 merge window or if the
consensus was that interrupt node be added to dts even though it works
without it.

Thanks,

-Joel


> day, we want to remove the redundant hwmod data if we already have DTS
> bindings covering the same requirements.
> --
> balbi
>

--001a11c339d2ace27b04df25d1f9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Felipe,<br><br>On Friday, June 14, 2013, Felipe Balbi  wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Hi,<br>
<br>
On Fri, Jun 14, 2013 at 02:54:33PM -0500, Joel A Fernandes wrote:<br>
&gt; Hi Tony, Vaibhav,<br>
&gt;<br>
&gt; &gt;&gt; I just doublechecked MMC rootfs on bone and evmsk as it&#39;s=
 the standard<br>
&gt; &gt;&gt; smoke test. My EVM is intermittent now so trying to coax it t=
o power up<br>
&gt; &gt;&gt; to reverify.<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Matt,<br>
&gt; &gt;<br>
&gt; &gt; Your branch is working for me, I tested it on EVM. Not sure what =
is wrong with manual rebasing<br>
&gt; &gt; I did yesterday. I will try to nail-down root-cause here.<br>
&gt; &gt;<br>
&gt; &gt; And you can submit the next version fixing the comments I have gi=
ven.<br>
&gt;<br>
&gt; The only comment I could find in the whole discussion was adding of<br=
>
&gt; the interrupts property. I tested I don&#39;t have any problem booting=
<br>
&gt; with Matt&#39;s patch, without having the interrupts property.<br>
<br>
might very well be, but we want to figure out why adding &quot;intrrupts&qu=
ot;<br>
causes issues. Why does it have to come through hwmod ? You might have<br>
uncovered a real problem which needs fixing. Besides, at the end of the</bl=
ockquote><div><br></div><div>No actually I think I wasn&#39;t very descript=
ive in my post.=A0There=A0is no problem here. Whether it comes from DT or n=
ot, it works in both cases . (I haven&#39;t tried adding interrupt node to =
dts but what I gathered from Vaibhav&#39;s post is that it works also when =
added to dts)</div>
<div><br></div><div>But I can=A0revisit Vaibhav&#39;s suggestion of adding =
it to dts for completeness sake.=A0My tree currently works and picks up the=
 interrupt info from hwmod. I just didn&#39;t see any activity on this thre=
ad for a while so I thought of enquiring=A0it was ok to pull it in for the =
3.11=A0merge window or if the consensus was that interrupt node be added to=
 dts even though it works without it.<span></span></div>
<div></div><div><br></div><div>Thanks,</div><div><br></div><div>-Joel</div>=
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
day, we want to remove the redundant hwmod data if we already have DTS<br>
bindings covering the same requirements.<br>
--<br>
balbi<br>
</blockquote>

--001a11c339d2ace27b04df25d1f9--

--===============3792420093623824256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3792420093623824256==--
