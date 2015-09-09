From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Wed, 9 Sep 2015 10:47:27 +0200
Message-ID: <55EFF21F.1010908@redhat.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com> <55EB02FD.5040403@redhat.com>
 <55EB8508.9030009@rock-chips.com>
 <CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw@mail.gmail.com>
 <55EC4A31.4060605@rock-chips.com>
 <CAECwjAgLuskgyHv50GOVN8fGOmQz+jo9PLCAr-POpYH6AszWSg@mail.gmail.com>
 <55ED3695.2030101@redhat.com>
 <CAECwjAjsi28gQ-iMZbEgFdoDoTcf0khnS0KRrzO1wnL1j0o0vQ@mail.gmail.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBJXEX6XQKGQEKQZ2NPI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAECwjAjsi28gQ-iMZbEgFdoDoTcf0khnS0KRrzO1wnL1j0o0vQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Yousong Zhou <yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 08-09-15 17:38, Yousong Zhou wrote:
> I just tried a method from allwinner's u-boot sources: retry the mode switch in
> case of an error [1].  It was accompanied with a comment quoted below:
>
> //retry for Toshiba emmc;for the first time Toshiba emmc change to HS
> //it will return response crc err,so retry
>
> Well, that 1GB card of mine is labeled as "pqi" made in Korea.  This workaround
> really worked and it succeeded on the second try, though I am not sure how
> anti-spec this can be (the spec says a power reset SHOULD be done in the case
> of crc error in the status data).
>
> The above change alone can make the card work.  I also noticed that allwinner's
> uboot will disable the clock first before setting it and re-enable it
> thereafter [2].  I can only guess that this is possibly some bugfix made
> by engineers of allwinner.  So I mimicked this approach and attached a patch
> here.

Thanks for this. So if I understand you correctly then just the:

"mmc: retry in the case of failing to switch to HS mode"

Patch is enough to make things work, right ?

That makes sense because the clock dance you are subscribing is something which
allwinner does in many places and it really is not necessary.

Can you do a similar patch for the kernel and test that too ?

And once you've a working kernel patch submit that to Ulf, with the mmc
list in the Cc?

If Ulf is willing to take this fix on the kernel side (I'm the sunxi-mmc maintainer
in the kernel, and the fix will get my ack), then I'm willing to take the u-boot
version of this fix.

Regards,

Hans
