From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] mmc: sunxi: use controller automatic
 clock gating.
Date: Wed, 12 Aug 2015 14:53:42 +0200
Message-ID: <CAOMqctSVN5y+Hs0_+aaZ=Gu_kr6_-1WONO585Y1bUEg79WJoAw@mail.gmail.com>
References: <cover.1439381423.git.hramrach@gmail.com> <c33b221f9b622e3bad9d855a7ad1887b82827244.1439381423.git.hramrach@gmail.com>
 <55CB3D92.6040403@redhat.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCQMLUOX54MBB7UDVWXAKGQESEBBB3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <55CB3D92.6040403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12 August 2015 at 14:35, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi,
>
> On 12-08-15 14:23, Michal Suchanek wrote:
>>
>> When core does not set the MMC_QUIRK_BROKEN_CLK_GATING flag enable
>> automatic hardware controlled clock gating on the mmc interface.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
>
> In general this looks good, but I wonder how intensively this has
> been tested ?

Unlike the wrong timeout it does not cause the boards to crash frequently ;-)

It would be nice if somebody actively using some board atm tested this.

> Also given the long latencies when using manual
> clock on/off support, have you done any testing to check what

I suspect the long latency is due to the controller flushing data to
the card or something like that since it happens only under load.

> sort of latencies this adds, e.g. Both with and without
> the patch, dump all the filesystem caches:
>
> echo 3 > /proc/sys/vm/drop_caches
>
> And then do:
>
> time cat /some/small/file/on/the/sdcard
>
> Do this at least 3 time both with and without the patch, and see
> if there are any noticable differences ?

Yes, it would be good idea to test.

Thanks

Michal
