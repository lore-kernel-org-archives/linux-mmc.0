From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] gpiolib: handle deferral probe error
Date: Fri, 7 Oct 2011 11:06:15 +0100
Message-ID: <20111007110615.7638e905@lxorguk.ukuu.org.uk>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
	<1317963790-29426-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317963790-29426-5-git-send-email-manjugk@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Dilan Lee <dilee@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <greg@kroah.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 07 Oct 2011 10:33:09 +0500
"G, Manjunath Kondaiah" <manjugk@ti.com> wrote:

> 
> The gpio library should return -EPROBE_DEFER in gpio_request
> if gpio driver is not ready.

Why not use the perfectly good existing error codes we have for this ?

We have EAGAIN and EUNATCH both of which look sensible.
