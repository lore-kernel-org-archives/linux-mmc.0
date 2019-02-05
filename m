From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Raspberry Pi sdhost cleanups
Date: Tue, 5 Feb 2019 14:34:51 +0100
Message-ID: <CAPDyKFqQF_psnUHYAxidZhb0pD_0diXJbem-KuDV=U=_ALg7dg@mail.gmail.com>
References: <cover.1549181242.git.lukas@wunner.de>
 <CAPDyKFq7fKpJMW1z5ydL_O-pfjN6jsD3HrZoOuEnc3eGtg4YYQ@mail.gmail.com>
 <20190205132652.xpy2aygu33lm43sz@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190205132652.xpy2aygu33lm43sz-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vaishali Thakkar <me-c39Wob3KZ2c64PEq3mRLUp/QNRX+jHPU@public.gmane.org>, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, Shraddha Barke <shraddha.6596-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 5 Feb 2019 at 14:26, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
>
> On Tue, Feb 05, 2019 at 01:48:31PM +0100, Ulf Hansson wrote:
> > On Sun, 3 Feb 2019 at 09:27, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> > > Three mostly trivial cleanups for the Raspberry Pi sdhost driver, v2.
> > >
> > > Only change since v1:  Use container_of() in patch [2/3] instead of
> > > open-coding the same (Alexander Graf).
> > >
> > > The issue addressed by patch [2/3] appears to be present in 32 other
> > > drivers as can be seen with "git grep -e '->mmc = ' -- drivers/mmc/host".
> > > Perhaps cleaning them up would be suitable for Outreachy applicants to
> > > get their feet wet?  Adding Shraddha Barke and Vaishali Thakkar to cc.
>
> FWIW this is now documented as something for Outreachy applicants
> to look into, I hope that's okay:
>
> https://github.com/nerdyvaishali/kernelbridge/commit/6f8cbf7f8e36

Great, cool, thanks! :-)

Kind regards
Uffe
