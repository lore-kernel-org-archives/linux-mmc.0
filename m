From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 09/11] mmc: omap_hsmmc: enhance pinctrl support
Date: Tue, 4 Jun 2013 09:52:42 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC2235F@DBDE04.ent.ti.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
	<1369995191-20855-10-git-send-email-gururaja.hebbar@ti.com>
	<CACRpkdbiYX5q8rvtV3Xcv7VdiJo2-6rGHNtvB1V=8C_qCpc=JA@mail.gmail.com>
	<CACRpkdYeh6UXnbUXiiZLPP+FUz11HKaD-FrHHaqUGX8AmA_p6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <CACRpkdYeh6UXnbUXiiZLPP+FUz11HKaD-FrHHaqUGX8AmA_p6g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 04, 2013 at 12:49:57, Linus Walleij wrote:
> On Tue, Jun 4, 2013 at 9:11 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On Fri, May 31, 2013 at 12:13 PM, Hebbar Gururaja
> > <gururaja.hebbar-l0cyMroinI0@public.gmane.org> wrote:
> >
> >> Amend the hsmmc controller to optionally take a pin control handle and
> >> set the state of the pins to:
> >>
> >> - "default" on boot, resume and before performing a mmc transfer
> >> - "idle" after initial default, after resume default, and after each
> >> mmc/sd card access
> >> - "sleep" on suspend()
> >>
> >> By optionally putting the pins into sleep state in the suspend callback
> >> we can accomplish two things.
> >> - One is to minimize current leakage from pins and thus save power,
> >> - second, we can prevent the IP from driving pins output in an
> >> uncontrolled manner, which may happen if the power domain drops the
> >> domain regulator.
> >>
> >> If any of the above pin states are missing in dt, a warning message
> >> about the missing state is displayed.
> >> If certain pin-states are not available, to remove this warning message
> >> pass respective state name with null phandler.
> >>
> >> Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> >> Cc: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> >> Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> >> Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >
> > This is perfectly correct.
> > Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> So please consider my other option given in patch 2 instead.

I will check how I can be a part of this implementation

> 
> Yours,
> Linus Walleij
> 


Regards, 
Gururaja
