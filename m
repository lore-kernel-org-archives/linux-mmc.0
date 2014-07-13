From: Vincent.Yang <Vincent.Yang@tw.fujitsu.com>
Subject: RE: [PATCH 1/4] mmc: sdhci: add quirk for voltage switch callback
Date: Sun, 13 Jul 2014 17:44:04 +0800
Message-ID: <830AC58E49A426478AC39824BC0FA915D8B8F21DDB@fmpitwmsex01.fmpi.sea.css.fujitsu.com>
References: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1405228870-5088-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20140713082136.GJ21766@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140713082136.GJ21766@n2100.arm.linux.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "t.takinishi@jp.fujitsu.com" <t.takinishi@jp.fujitsu.com>, "andy.green@linaro.org" <andy.green@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "anton@enomsg.org" <anton@enomsg.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "mollie.wu@linaro.org" <mollie.wu@linaro.org>, "olof@lixom.net" <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

>-----Original Message-----
>From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
>On Sun, Jul 13, 2014 at 01:21:07PM +0800, Vincent Yang wrote:
>> @@ -1763,6 +1763,11 @@ static int sdhci_do_start_signal_voltage_switch(struct
>sdhci_host *host,
>>               ctrl |= SDHCI_CTRL_VDD_180;
>>               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>> +             /* Some controller need to do more when switching */
>> +             if ((host->quirks2 & SDHCI_QUIRK2_VOLTAGE_SWITCH) &&
>> +                 host->ops->voltage_switch)
>> +                     host->ops->voltage_switch(host);
>> +
>
>Why do you heed SDHCI_QUIRK2_VOLTAGE_SWITCH?  Isn't populating
>ops->voltage_switch enough? to indicate that something needs to be
>done?

Hi Russell,
I will update it as below and remove SDHCI_QUIRK2_VOLTAGE_SWITCH in
next version.
+               /* Some controller need to do more when switching */
+               if (host->ops->voltage_switch)
+                       host->ops->voltage_switch(host);
+

Thanks a lot for your review!

Best regards,
Vincent Yang

>
>It would also be better to turn sdhci.c into a library, and have
>the platform driver call the appropriate functions in sdhci rather
>than having sdhci be a core driver with loads of quirks.  This is
>what I've done in my previous series where I changed stuff such as
>the set_bus_width(), set_uhs_signaling() and similar callbacks.
>
>So, it probably makes more sense to split
>sdhci_do_start_signal_voltage_switch() into a load of smaller library
>functions which drivers can call in an appropriate sequence, rather
>than having a quirk hook.
>
>The problem with quirk hooks is that what is right for one device
>is not right for another device - eventually you end up with lots
>of quirk callbacks scattered on every alternate line.  That doesn't
>scale.
>
>Experienced kernel programmers know this and this is why words like
>"framework" fill those who have encountered this problem with dread.
>sdhci.c is a prime example of this kind of design mistake.
>
>--
>FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
>according to speedtest.net.
