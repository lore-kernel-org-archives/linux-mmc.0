From: "Franky Lin" <frankyl@broadcom.com>
Subject: Re: Where to power on the wifi device before loading the
 driver.
Date: Fri, 15 Jun 2012 09:24:41 -0700
Message-ID: <4FDB61C9.9020505@broadcom.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
 <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Ni <wni@nvidia.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Mursalin Akon <makon@nvidia.com>, 'Stephen Warren' <swarren@wwwdotorg.org>, "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rakesh Kumar <krakesh@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 06/14/2012 11:09 PM, Wei Ni wrote:
> I talked with Franky, this power sequence is generally for 4329, so it mean this sequence can be put into the wifi driver.

Hold on. It's generally for 4329. But fullmac supports 4329/4330 along 
with USB dongle chips. Also more chips are incoming. I dont think it's a 
good idea to add *this* power sequence into brcmfmac.

Franky
