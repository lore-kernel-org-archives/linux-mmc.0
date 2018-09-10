From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: Rockchip RV1108 mainline kernel support
Date: Mon, 10 Sep 2018 14:42:36 +0200
Message-ID: <8240937.RLPrvYGblP@phil>
References: <CAAPZna3aGkUmDeAwM4J6LpeC9m1VA=CUQN_ChiwvTLkaE2zdrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAAPZna3aGkUmDeAwM4J6LpeC9m1VA=CUQN_ChiwvTLkaE2zdrw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Fabio Berton <fabio.berton-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>
Cc: andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Fabio,

Am Donnerstag, 19. Juli 2018, 15:53:02 CEST schrieb Fabio Berton:
> We're adding support to a custom Rockchip RV1108 in mainline kernel.
> 
> Currently this custom board runs fine on the Rockchip 3.10 vendor kernel.
> 
> The main problems is that kernel 4.17 can't detect eMMC.
> 
> I would appreciate any help on how to make the mainline kernel to
> detect eMMC on this board

Maybe you already solved your issue already, I just found your mail in
my inbox again.

So far I haven't gotten any rv1108-based board to do tests on, so it's a
bit hard trying to find problem sources.

On most recent Rockchip boards the (dw-)mmc runs just fine, but in your
log + kernel commandline I noticed that you could try to add the
"rootwait"  commandline option, as at the time of the failing rootfs the
emmc may simply not have finished probing the card yet.


Heiko
