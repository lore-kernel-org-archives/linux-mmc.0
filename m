From: Dushara Jayasinghe <dushara@successful.com.au>
Subject: Fwd: marvell wifi sdio device not detected
Date: Mon, 12 Dec 2016 07:50:18 +1100
Message-ID: <CAN683nuH5ikzvpBfRaRcuwUDN+R1kW_KcBzxKFE2eniuOOpOeA@mail.gmail.com>
References: <CAN683nsP7eY_vkSG52Snd64q1BF+Q=s2rqpAakbZ3e7Q=ZAJ+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34815 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753620AbcLKUuU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Dec 2016 15:50:20 -0500
Received: by mail-io0-f180.google.com with SMTP id p42so145724469ioo.1
        for <linux-mmc@vger.kernel.org>; Sun, 11 Dec 2016 12:50:19 -0800 (PST)
In-Reply-To: <CAN683nsP7eY_vkSG52Snd64q1BF+Q=s2rqpAakbZ3e7Q=ZAJ+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Re-posting message sent to kernelnewbies ML. Please let me know if I'm
posting to the wrong list.

Hi,

I'm trying to bring up a marvell 8787 based wifi chip on an atmel
sama5d2 based board. The kernel version I'm on is 4.4 (specific version
is at https://github.com/linux4sam/linux-at91/tree/linux4sam_5.5).

The wifi controller is a WYSBMVGXB from TAIYO YUDEN. The device tree
configuration for the mmc bus I've used is as follows:

                 sdmmc1: sdio-host@b0000000 {
                         pinctrl-names = "default";
                         pinctrl-0 = <&pinctrl_sdmmc1_default>;
                         mmc-pwrseq = <&sdhci0_pwrseq>;
                         bus-width = <4>;
                         broken-cd;
                         status = "okay"; /* conflict with qspi0 */
                 };

I've used a modified pwrseq driver that drives the IO as specified in
the controller data sheet and confirmed that the lines are controlled as
expected during startup. I can also see some clock activity on the sdio
bus, but doesn't seem to detect a device on the bus.

The mwifiex_sdio driver is statically compiled.

Can anyone offer any suggestions on how I can debug this issue?

Also, I don't quite understand how the mwifiex_sdio driver is attached
to that specific bus. My understanding based on the i2c, spi buses are,
the device tree can specify the devices hanging off these buses and the
appropriate driver is loaded. However, the mmc/sdio dts entries dob't
seem to be following the same pattern.

Thank you and regards,

Dushara
