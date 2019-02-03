From: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v2 2/3] mmc: bcm2835: Drop pointer to mmc_host from
 bcm2835_host
Date: Sun, 3 Feb 2019 16:57:28 +0100
Message-ID: <06B4874F-5C1E-4502-9F60-CDAD37EAAEED@suse.de>
References: <cover.1549181242.git.lukas@wunner.de>
 <ffa656c9f2c0e397a38e5827ba586f13e723f81b.1549181242.git.lukas@wunner.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <ffa656c9f2c0e397a38e5827ba586f13e723f81b.1549181242.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vaishali Thakkar <me-c39Wob3KZ2c64PEq3mRLUp/QNRX+jHPU@public.gmane.org>, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, Shraddha Barke <shraddha.6596-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org



> Am 03.02.2019 um 09:27 schrieb Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>:
> 
> The BCM2835 MMC host driver uses a pointer to get from the private
> bcm2835_host structure to the generic mmc_host structure.  However the
> latter is always immediately preceding the former in memory, so compute
> its address with a subtraction (which is cheaper than a dereference) and
> drop the superfluous pointer.
> 
> No functional change intended.
> 
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> Cc: Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
> Cc: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>

Reviewed-by: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>

Alex
