From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFC 2/3] mmc: core: add new cap for 3.3V only DDR MMCs
Date: Sat, 6 Aug 2016 16:42:33 +0200
Message-ID: <9356c009-4b34-9d3c-c4b9-c89ced2f8412@denx.de>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-3-git-send-email-stefan.wahren@i2se.com>
 <0e38d62a-b3d0-30ca-fca9-bb740ae54d0a@denx.de>
 <16443443.114784.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <16443443.114784.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org, Otavio Salvador <otavio@ossystems.com.br>, Holger Schurig <holgerschurig@gmail.com>, linux-mmc@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 08/06/2016 04:18 PM, Stefan Wahren wrote:
> Hi Marek,
> 
>> Marek Vasut <marex@denx.de> hat am 6. August 2016 um 15:14 geschrieben:
>>
>>
>> On 08/06/2016 02:55 PM, Stefan Wahren wrote:
>>> This patch based on the work of Fabio Estevam:
>>> "[PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
>>> 'no-1-8-v' is present"
>>>
>>> It adds the support for 3.3V only DDR MMC hosts.
>>
>> Do such cards even exist ? Do you have a link where I can find some ?
> 
> i never said anything about SD cards. I mean eMMC modules which usually have 8
> data pins like this one [1].
> 
> Please don't blame me if it's not compatible to i.MX28. It's only an example.
> 
> [1] -
> http://datasheet.octopart.com/THGBM3G4D1FBAIGH2H-Toshiba-datasheet-20748880.pdf

Interesting, thanks!

-- 
Best regards,
Marek Vasut
