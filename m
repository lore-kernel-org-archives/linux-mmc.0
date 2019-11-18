From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: arm64: dts: rockchip: Disable HS400 for mmc on rk3399-roc-pc
Date: Mon, 18 Nov 2019 02:01:16 +0100
Message-ID: <14740383.9LiiEhnQET@phil>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
 <20190301153348.29870-2-christoph.muellner@theobroma-systems.com>
 <367bf78a-f079-f0b4-68fe-52c86823c174@fivetechno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <367bf78a-f079-f0b4-68fe-52c86823c174-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Markus Reichl <m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tony Xie <tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vicente Bergas <vicencb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Klaus Goger <klaus.goger-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Philipp Tomsich <philipp.tomsich-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Randy Li <ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ezequiel Garcia <ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Christoph Muellner <christoph.muellner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Am Montag, 11. November 2019, 10:51:04 CET schrieb Markus Reichl:
> Working with rootfs on two 128GB mmcs on rk3399-roc-pc.
> 
> One (mmc name 128G72, one screw hole) works fine in HS400 mode.
> Other (mmc name DJNB4R, firefly on pcb, two screw holes) gets lots of
> mmc1: "running CQE recovery", even hangs with damaged fs,
> when running under heavy load, e.g. compiling kernel.
> Both run fine with HS200.
> 
> Disabling CQ with patch mmc: core: Add MMC Command Queue Support kernel parameter [0] did not help.
> [0] https://gitlab.com/ayufan-repos/rock64/linux-mainline-kernel/commit/54e264154b87dfe32a8359b2726e2d5611adbaf3
> 
> Therefore I propose to disable HS400 mode on roc-pc for now.
> 
> Signed-off-by: Markus Reichl <m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>

applied for 5.6 (or maybe still 5.5)

Thanks
Heiko
