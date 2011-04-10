From: anish singh <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize
	latency
Date: Sun, 10 Apr 2011 09:03:49 +0530
Message-ID: <BANLkTikwCveocjPdoMoLEVpNneKkq66s4g@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<BANLkTikZVDejarZ4O5KgNS7S4fxBLSmANA@mail.gmail.com>
	<BANLkTikVeXvfSBS-xLDXVdesKJpKdtUVqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5268293759741690506=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <BANLkTikVeXvfSBS-xLDXVdesKJpKdtUVqg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Jae hoon Chung <jh80.chung-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--===============5268293759741690506==
Content-Type: multipart/alternative; boundary=20cf307cfff499f6ef04a08820a4

--20cf307cfff499f6ef04a08820a4
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 9, 2011 at 5:25 PM, Jae hoon Chung <jh80.chung-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi Per..
>
> I'm applied your patch..and sent the patch about dw_mmc.c.
> I think good this approach..
>
Forlin,i too want to test this patch of yours but unfortunately i have
samsung board+SDHCI host controller so i guess i just need to write pre_req
and post_req functions and that would enable this(nonblock mmc request) on
my board.Hope i am right?

>
> Tested-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> Regards,
> Jaehoon Chung
>
> 2011/4/9 Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> > On Wed, Apr 6, 2011 at 9:07 PM, Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> wrote:
> >
> >> The intention for introducing none blocking mmc requests is to minimize
> the
> >> time between a mmc request ends and another mmc request starts.
> >
> > Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> FWIW, I've looked at
> the
> > patches so many times I'm already blind for any remaining bugs...
> >
> > Yours,
> > Linus Walleij
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>  > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--20cf307cfff499f6ef04a08820a4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Sat, Apr 9, 2011 at 5:25 PM, Jae hoon Chung <=
span dir=3D"ltr">&lt;<a href=3D"mailto:jh80.chung-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">jh80.chung@gma=
il.com</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">Hi Per..<br><br>I&#39;m applied =
your patch..and sent the patch about dw_mmc.c.<br>I think good this approac=
h..<br>
</blockquote>
<div>Forlin,i too want to test this patch of yours but unfortunately i have=
 samsung board+SDHCI host controller so i guess i just need to write pre_re=
q and post_req functions and that would enable this(nonblock mmc request) o=
n my board.Hope i am right?</div>

<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote"><br>Tested-by: Jaehoon Chung &lt=
;<a href=3D"mailto:jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<b=
r>
<br>Regards,<br>Jaehoon Chung<br><br>2011/4/9 Linus Walleij &lt;<a href=3D"=
mailto:linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;:<br>
<div class=3D"im">&gt; On Wed, Apr 6, 2011 at 9:07 PM, Per Forlin &lt;<a hr=
ef=3D"mailto:per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt; wrote:<br=
>&gt;<br>&gt;&gt; The intention for introducing none blocking mmc requests =
is to minimize the<br>
&gt;&gt; time between a mmc request ends and another mmc request starts.<br=
>&gt;<br>&gt; Acked-by: Linus Walleij &lt;<a href=3D"mailto:linus.walleij@l=
inaro.org">linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt; FWIW, I&#39;ve looked at the<br=
>
&gt; patches so many times I&#39;m already blind for any remaining bugs...<=
br>&gt;<br>&gt; Yours,<br>&gt; Linus Walleij<br>&gt; --<br></div>&gt; To un=
subscribe from this list: send the line &quot;unsubscribe linux-mmc&quot; i=
n<br>

<div>
<div></div>
<div class=3D"h5">&gt; the body of a message to <a href=3D"mailto:majordomo=
@vger.kernel.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>&gt; More majordomo info=
 at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-info.html" target=3D"=
_blank">http://vger.kernel.org/majordomo-info.html</a><br>
&gt;<br>--<br>To unsubscribe from this list: send the line &quot;unsubscrib=
e linux-kernel&quot; in<br>the body of a message to <a href=3D"mailto:major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>More majordomo info =
at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-info.html" target=3D"_=
blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =C2=A0<a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br></div></div></blockquote></div><br=
>

--20cf307cfff499f6ef04a08820a4--


--===============5268293759741690506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============5268293759741690506==--
