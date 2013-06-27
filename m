From: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] AM33xx: MMC resources from DT without HWMOD data
Date: Thu, 27 Jun 2013 09:26:04 -0500
Message-ID: <CAD=GYpa9LQ1fV6=O9B65sJURVAigsgXCPLWav8cHXTuGQXPc9A@mail.gmail.com>
References: <1372209808-6532-1-git-send-email-joelagnel@ti.com>
	<CAD=GYpbdVVrh-tiqOcbHi3mkWRJUBdx0EsEZEFVVbgFgcCWgsw@mail.gmail.com>
	<51CC2A1E.2040003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <51CC2A1E.2040003-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, joelf-l0cyMroinI0@public.gmane.org, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Benoit,

On Thu, Jun 27, 2013 at 7:03 AM, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org> wrote:
> Hi Joel,
>
> On 06/26/2013 05:28 AM, Joel A Fernandes wrote:
>> On Tue, Jun 25, 2013 at 8:23 PM, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org> wrote:
>>> From: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>> This series is fixes to get MMC working on AM33XX without HWMOD data.
>>> On removal of HWMOD data, interrupt and register properties need to be provided
>>> for the driver to function correctly.
>>
>> Please don't pull patches authored by me in this series. I have posted
>> them with my wrong email address by mistake. I will correct my email
>> during the next repost, after a round of review. Matt's patches in the
>> series are still good though.
>
> In that case, please repost these in two series to avoid pulling the DTS
> files in the MMC tree.

The series has been replaced with the single patch:
"[PATCH v2] ARM: dts: add AM33XX MMC support"
http://marc.info/?l=linux-omap&m=137230403815943&w=2

Some patches were squashed and others dropped in the series resulting
in the single
patch above. This patch should be good to apply

Thanks,

-Joel

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
