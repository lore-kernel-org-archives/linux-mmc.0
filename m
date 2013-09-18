From: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Adding aliases to mmc
Date: Wed, 18 Sep 2013 07:47:01 +0200
Message-ID: <52393E55.6080200@gmail.com>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Fabio,

Am 17.09.2013 20:04, schrieb Fabio Estevam:
> Hi Dirk,
>
> I have adapted your patch at:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/111022.html
>
> and tested it on 3.12-rc1 on a mx6qsabresd board.
>
> Do you have plans to submit it? Maybe as a RFC?
>
> It solves the mmcblkX order issue on my tests and it would be nice we
> could have this problem addressed.

If I remember the history correctly, instead of the approach linked 
above, I've submitted an alternative solution:

http://marc.info/?l=linux-mmc&m=134423822729031

But this hasn't found it's way into mainline, too.

Best regards

Dirk



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
