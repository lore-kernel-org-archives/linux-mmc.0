From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [STLinux Kernel] [PATCH v3 10/10] MAINTAINERS: Add sdhci-st file
 to ARCH/STI architecture
Date: Tue, 22 Jul 2014 14:13:32 +0200
Message-ID: <53CE556C.10607@st.com>
References: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org>	<1401899424-1365-11-git-send-email-peter.griffin@linaro.org>
 <53A80754.9000900@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53A80754.9000900@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, khilman@linaro.org
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, kernel@stlinux.com
List-Id: linux-mmc@vger.kernel.org

Hi Olof, Arnd, Kevin,

	I am preparing two tags for v3.17 regarding STi platform.
	One for DT, and one for defconfigs.

	Except this one, I have no patches for ARM-SoC.
	Can you take this patch directly?

	Or should I send a pull request with this one only?

Regards,
Maxime

On 06/23/2014 12:54 PM, Maxime Coquelin wrote:
>
>
> On 06/04/2014 06:30 PM, Peter Griffin wrote:
>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
>
>> --- MAINTAINERS | 1 + 1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS index 6dc67b1..19dc265
>> 100644 --- a/MAINTAINERS +++ b/MAINTAINERS @@ -1306,6 +1306,7 @@ F:
>> drivers/pinctrl/pinctrl-st.c F:	drivers/media/rc/st_rc.c F:
>> drivers/i2c/busses/i2c-st.c F:	drivers/tty/serial/st-asc.c +F:
>> drivers/mmc/host/sdhci-st.c
>>
>> ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT M:	Lennert Buytenhek
>> <kernel@wantstofly.org>
>>
>
>
>
> _______________________________________________
> Kernel mailing list
> Kernel@stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
>
