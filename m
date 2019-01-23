From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: bcm2835: Drop pointer to mmc_host from
 bcm2835_host
Date: Wed, 23 Jan 2019 17:23:34 +0100 (CET)
Message-ID: <403326446.711096.1548260614564@email.ionos.de>
References: <9b09dda9817f61a0cfb3991abf11abb1fe7f41c9.1547911374.git.lukas@wunner.de>
 <2140f7852cd0186ec705057d83992a49fbc625f4.1547911374.git.lukas@wunner.de>
 <461f638c-7bf9-1db2-cdf1-6acfa2c8c51a@suse.de>
 <20190122134404.gcbjpbnm2tokrjc7@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190122134404.gcbjpbnm2tokrjc7-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

> Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> hat am 22. Januar 2019 um 14:44 geschrieben:
> 
> 
> On Mon, Jan 21, 2019 at 03:20:37PM +0100, Alexander Graf wrote:
> > On 01/19/2019 04:31 PM, Lukas Wunner wrote:
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -478,6 +478,11 @@ static inline void *mmc_priv(struct mmc_host *host)
> > >   	return (void *)host->private;
> > >   }
> > > +static inline struct mmc_host *mmc_from_priv(void *priv)
> > > +{
> > > +	return priv - offsetof(struct mmc_host, private);
> > 
> > Can you use container_of() instead here?
> 
> Absolutely.  I've no idea why I didn't use it in the first place.

Except of this i'm fine with the whole series:

Tested-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>

Please add a cover letter for V2.

Thanks

> 
> Thanks,
> 
> Lukas
