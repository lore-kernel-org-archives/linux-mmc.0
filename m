From: Sachin Nikam <sachinikam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize
	latency
Date: Mon, 11 Apr 2011 14:37:32 +0530
Message-ID: <BANLkTimJdTG+1LD2+hN8SC9-YsbRZ4jBZA@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<BANLkTikZVDejarZ4O5KgNS7S4fxBLSmANA@mail.gmail.com>
	<BANLkTikVeXvfSBS-xLDXVdesKJpKdtUVqg@mail.gmail.com>
	<BANLkTikwCveocjPdoMoLEVpNneKkq66s4g@mail.gmail.com>
	<BANLkTikoj6UTx08ntZaMM15taKRXjrU_Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6940960429367093541=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <BANLkTikoj6UTx08ntZaMM15taKRXjrU_Mg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jae hoon Chung <jh80.chung-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, anish singh <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--===============6940960429367093541==
Content-Type: multipart/alternative; boundary=20cf307f32e0e0470204a0a0e73b

--20cf307f32e0e0470204a0a0e73b
Content-Type: text/plain; charset=ISO-8859-1

Does anybody knows which kernel version will have support for SD4.0 specs
UHS-2?


On Mon, Apr 11, 2011 at 2:33 PM, Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> On 10 April 2011 05:33, anish singh <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> >
> > On Sat, Apr 9, 2011 at 5:25 PM, Jae hoon Chung <jh80.chung-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >>
> >> Hi Per..
> >>
> >> I'm applied your patch..and sent the patch about dw_mmc.c.
> >> I think good this approach..
> >
> > Forlin,i too want to test this patch of yours but unfortunately i have
> > samsung board+SDHCI host controller so i guess i just need to write
> pre_req
> > and post_req functions and that would enable this(nonblock mmc request)
> on
> > my board.Hope i am right?
> You are right. The  SDHCI driver should work just fine without
> implementing pre_req and post_req but you wont see any performance
> increasing for DMA usage.
> In order to benefit from the patchset you need to implement pre_req
> and post_req.
>
> If you run into trouble implementing those hooks or if you have any
> questions please let me know.
>
> Regards,
> Per
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Have a nice time !!!

Cheers,
Sachin.

--20cf307f32e0e0470204a0a0e73b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Does anybody knows which kernel version will have support for SD4.0 sp=
ecs UHS-2?</div>
<div><br>=A0</div>
<div class=3D"gmail_quote">On Mon, Apr 11, 2011 at 2:33 PM, Per Forlin <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">per.forlin@linar=
o.org</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">On 10 April 2011 05:33, anish si=
ngh &lt;<a href=3D"mailto:anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">anish198519851985@gm=
ail.com</a>&gt; wrote:<br>
&gt;<br>&gt;<br>&gt; On Sat, Apr 9, 2011 at 5:25 PM, Jae hoon Chung &lt;<a =
href=3D"mailto:jh80.chung-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">jh80.chung-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br=
>&gt;&gt;<br>&gt;&gt; Hi Per..<br>&gt;&gt;<br>&gt;&gt; I&#39;m applied your=
 patch..and sent the patch about dw_mmc.c.<br>
&gt;&gt; I think good this approach..<br>&gt;<br>&gt; Forlin,i too want to =
test this patch of yours but unfortunately i have<br>&gt; samsung board+SDH=
CI host controller so i guess i just need to write pre_req<br>&gt; and post=
_req functions and that would enable this(nonblock mmc request) on<br>
&gt; my board.Hope i am right?<br>You are right. The =A0SDHCI driver should=
 work just fine without<br>implementing pre_req and post_req but you wont s=
ee any performance<br>increasing for DMA usage.<br>In order to benefit from=
 the patchset you need to implement pre_req<br>
and post_req.<br><br>If you run into trouble implementing those hooks or if=
 you have any<br>questions please let me know.<br><br>Regards,<br>Per<br><f=
ont color=3D"#888888">--<br>To unsubscribe from this list: send the line &q=
uot;unsubscribe linux-mmc&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>More majordomo info at =A0<a href=3D"http://vge=
r.kernel.org/majordomo-info.html" target=3D"_blank">http://vger.kernel.org/=
majordomo-info.html</a><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Have a nice time=
 !!!<br><br>Cheers,<br>Sachin.<br>

--20cf307f32e0e0470204a0a0e73b--


--===============6940960429367093541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============6940960429367093541==--
