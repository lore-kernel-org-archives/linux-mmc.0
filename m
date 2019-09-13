From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: Re: [PATCH 1/4] MMC: Ingenic: Adjust the macro definition name.
Date: Fri, 13 Sep 2019 23:59:11 +0800
Message-ID: <5D7BBCCF.2010600@zoho.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1567669089-88693-2-git-send-email-zhouyanjie@zoho.com>
 <e9ef3a9093e8572eb3be2aa654dd30069c493a4b.camel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e9ef3a9093e8572eb3be2aa654dd30069c493a4b.camel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@collabora.com>, linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, paul.burton@mips.com, linus.walleij@linaro.org, paul@crapouillou.net, malat@debian.org, yuehaibing@huawei.com, robh+dt@kernel.org, mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com
List-Id: linux-mmc@vger.kernel.org

Hi Ezequiel,

On 2019=E5=B9=B409=E6=9C=8813=E6=97=A5 23:32, Ezequiel Garcia wrote:
> Hi Zhou,
>
> Thanks for your interest in this driver, I'm glad
> so see it's more used.
>
> On Thu, 2019-09-05 at 15:38 +0800, Zhou Yanjie wrote:
>> Adjust the macro definition name to match the corresponding
>> register name in the datasheet.
>>
> It's not really an issue to have slighlt different
> names on the macros. They are currently sufficiently
> descriptive, and I don't think it's deserves a patch.
Thanks for your advice, I'll drop this in v2. Do you have any suggestions
for the other three patches?

Best regards!
>
> Thanks,
> Ezequiel
>
>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>> ---
>>   drivers/mmc/host/jz4740_mmc.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc=
.c
>> index ffdbfaa..1b1fcb7 100644
>> --- a/drivers/mmc/host/jz4740_mmc.c
>> +++ b/drivers/mmc/host/jz4740_mmc.c
>> @@ -28,7 +28,7 @@
>>   #include <asm/mach-jz4740/dma.h>
>>  =20
>>   #define JZ_REG_MMC_STRPCL=090x00
>> -#define JZ_REG_MMC_STATUS=090x04
>> +#define JZ_REG_MMC_STAT=09=090x04
>>   #define JZ_REG_MMC_CLKRT=090x08
>>   #define JZ_REG_MMC_CMDAT=090x0C
>>   #define JZ_REG_MMC_RESTO=090x10
>> @@ -40,7 +40,7 @@
>>   #define JZ_REG_MMC_IREG=09=090x28
>>   #define JZ_REG_MMC_CMD=09=090x2C
>>   #define JZ_REG_MMC_ARG=09=090x30
>> -#define JZ_REG_MMC_RESP_FIFO=090x34
>> +#define JZ_REG_MMC_RES=09=090x34
>>   #define JZ_REG_MMC_RXFIFO=090x38
>>   #define JZ_REG_MMC_TXFIFO=090x3C
>>   #define JZ_REG_MMC_DMAC=09=090x44
>> @@ -391,7 +391,7 @@ static void jz4740_mmc_clock_disable(struct jz4740_m=
mc_host *host)
>>  =20
>>   =09writew(JZ_MMC_STRPCL_CLOCK_STOP, host->base + JZ_REG_MMC_STRPCL);
>>   =09do {
>> -=09=09status =3D readl(host->base + JZ_REG_MMC_STATUS);
>> +=09=09status =3D readl(host->base + JZ_REG_MMC_STAT);
>>   =09} while (status & JZ_MMC_STATUS_CLK_EN && --timeout);
>>   }
>>  =20
>> @@ -403,7 +403,7 @@ static void jz4740_mmc_reset(struct jz4740_mmc_host =
*host)
>>   =09writew(JZ_MMC_STRPCL_RESET, host->base + JZ_REG_MMC_STRPCL);
>>   =09udelay(10);
>>   =09do {
>> -=09=09status =3D readl(host->base + JZ_REG_MMC_STATUS);
>> +=09=09status =3D readl(host->base + JZ_REG_MMC_STAT);
>>   =09} while (status & JZ_MMC_STATUS_IS_RESETTING && --timeout);
>>   }
>>  =20
>> @@ -446,7 +446,7 @@ static void jz4740_mmc_transfer_check_state(struct j=
z4740_mmc_host *host,
>>   {
>>   =09int status;
>>  =20
>> -=09status =3D readl(host->base + JZ_REG_MMC_STATUS);
>> +=09status =3D readl(host->base + JZ_REG_MMC_STAT);
>>   =09if (status & JZ_MMC_STATUS_WRITE_ERROR_MASK) {
>>   =09=09if (status & (JZ_MMC_STATUS_TIMEOUT_WRITE)) {
>>   =09=09=09host->req->cmd->error =3D -ETIMEDOUT;
>> @@ -580,10 +580,10 @@ static bool jz4740_mmc_read_data(struct jz4740_mmc=
_host *host,
>>   =09/* For whatever reason there is sometime one word more in the fifo =
then
>>   =09 * requested */
>>   =09timeout =3D 1000;
>> -=09status =3D readl(host->base + JZ_REG_MMC_STATUS);
>> +=09status =3D readl(host->base + JZ_REG_MMC_STAT);
>>   =09while (!(status & JZ_MMC_STATUS_DATA_FIFO_EMPTY) && --timeout) {
>>   =09=09d =3D readl(fifo_addr);
>> -=09=09status =3D readl(host->base + JZ_REG_MMC_STATUS);
>> +=09=09status =3D readl(host->base + JZ_REG_MMC_STAT);
>>   =09}
>>  =20
>>   =09return false;
>> @@ -614,7 +614,7 @@ static void jz4740_mmc_read_response(struct jz4740_m=
mc_host *host,
>>   {
>>   =09int i;
>>   =09uint16_t tmp;
>> -=09void __iomem *fifo_addr =3D host->base + JZ_REG_MMC_RESP_FIFO;
>> +=09void __iomem *fifo_addr =3D host->base + JZ_REG_MMC_RES;
>>  =20
>>   =09if (cmd->flags & MMC_RSP_136) {
>>   =09=09tmp =3D readw(fifo_addr);
>> @@ -797,7 +797,7 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
>>   =09struct mmc_command *cmd =3D host->cmd;
>>   =09uint32_t irq_reg, status, tmp;
>>  =20
>> -=09status =3D readl(host->base + JZ_REG_MMC_STATUS);
>> +=09status =3D readl(host->base + JZ_REG_MMC_STAT);
>>   =09irq_reg =3D jz4740_mmc_read_irq_reg(host);
>>  =20
>>   =09tmp =3D irq_reg;
>
>
