From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] tegra/mmc: add pm_flags
Date: Fri, 25 Mar 2011 20:43:17 -0400
Message-ID: <m3mxkik8yi.fsf@pullcord.laptop.org>
References: <20110326000712.DD5D3208182@grundler.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110326000712.DD5D3208182-WbMPnaG8TBjlUACayq9hv/yj43VRqXoZVpNB7YpNyf8@public.gmane.org> (Grant
	Grundler's message of "Fri, 25 Mar 2011 17:07:12 -0700 (PDT)")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Grundler <grundler-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vrao-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Grant,

On Fri, Mar 25 2011, Grant Grundler wrote:
> Enable fast bcm4329 WIFI suspend/resume on Tegra2 board.
>
> This part allows the mach-tegra support tell the tegra MMC host controller
> to NOT turn off power for the MMC controller the WIFI part lives behind.
> Thus bcm4329 firmware doesn't need to be reloaded.
>
> Signed-off-by: Venkat Rao <vrao@broadcom>
> Tested-by: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Reviewed-by: Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

One more thing -- who wrote this patch?  If Venkat, it should have a:

From: Venkat Rao <vrao-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

line in either the mail headers or the message body.  If you, it should
have your S-o-b.  The way you've sent it tells Git that you wrote the
patch.

Thanks,

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
