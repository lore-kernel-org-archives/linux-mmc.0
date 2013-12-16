From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 03/16] ARM: dts: provide DMA config to pxamci
Date: Mon, 16 Dec 2013 10:58:10 +0100
Message-ID: <52AECEB2.4070807@gmail.com>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>	
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>	
 <1386901645-28895-4-git-send-email-ynvich@gmail.com>	
 <201312142006.26979.arnd@arndb.de>
 <1387049660.7152.317.camel@host5.omatika.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1387049660.7152.317.camel@host5.omatika.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Ianovich <ynvich@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, DOCUMENTATION <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Landley <rob@landley.net>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 12/14/2013 08:34 PM, Sergei Ianovich wrote:
> On Sat, 2013-12-14 at 20:06 +0100, Arnd Bergmann wrote:

>> The patch looks ok in case we are merging your patches for 3.14
>> and Daniel's patches later than that. If they end up in the
>> same merge window however, we'd have to be care to resolve
>> the obvious conflict in a proper way.
> 
> The most recently published Daniel's patch (Aug 2013) wraps
> IORESOURCE_DMA handling on DT presence in a similar way,

Erm, no it doesn't. My patch uses dma_request_slave_channel_compat() in
DT case, and that works fine with the current version of pdma, and
there's no need to read the "dmas" properties directly.

If you want to provide a way to simply denote the dma channel numbers,
without looking at the actual phandle, then yes, we could merge this
patch first, but it would be effectively reverted a proper implementation.


Daniel
