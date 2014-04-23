From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] Re: [PATCH v8 10/17] ARM: dts: sun6i: Add mmc clocks
Date: Wed, 23 Apr 2014 11:49:29 +0200
Message-ID: <53578CA9.2070703@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <1398164497-14212-11-git-send-email-hdegoede@redhat.com>
 <20140423094426.GK24905@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140423094426.GK24905@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, =?ISO-8859-1?Q?David_Lanzend=F6?= =?ISO-8859-1?Q?rfer?= <david.lanzendoerfer@o2s.ch>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 04/23/2014 11:44 AM, Maxime Ripard wrote:
> On Tue, Apr 22, 2014 at 01:01:30PM +0200, Hans de Goede wrote:
>> Add clk-nodes for the mmc clocks.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/sun6i-a31.dtsi | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>> index d45efa7..12bcc17 100644
>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>> @@ -198,6 +198,38 @@
>>  					"apb2_uart4", "apb2_uart5";
>>  		};
>>  
>> +		mmc0_clk: clk@01c20088 {
>> +			#clock-cells = <0>;
>> +			compatible = "allwinner,sun4i-a10-mod0-clk";
> 
> This is simply not true.
> 
> module0 clocks don't have any kind of phase control, while we do here.

We've the exact same situation for all of sun4i, sun5i and sun7i. IMHO
it would be much simpler to keep things uns sync everywhere, until we actually
know how we want to deal with the phase control stuff, and then change
the compatible, etc. everywhere at once.

Regards,

Hans
