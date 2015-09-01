From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [RFC 0/3] mmc: sdhci: pass signal voltage as an argument to ->voltage_switch()
Date: Wed,  2 Sep 2015 01:02:15 +0530
Message-ID: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35099 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbIATfV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2015 15:35:21 -0400
Received: by pacfv12 with SMTP id fv12so5375862pac.2
        for <linux-mmc@vger.kernel.org>; Tue, 01 Sep 2015 12:35:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

In order to do particular voltage specific configuration in
sdhci_ops->voltage_switch() callback function, we need to
pass respective voltage value as well.

So this patch series pass signal voltage to the controller
specific ->voltage_switch() callback.
Adds controller specific configuration for other voltages as well,
and add implementation for ->voltage_switch to pxav3 driver.


Note:
Currently ->voltage_switch() callback is only supported
in f_sdh30 driver. And I am not sure on the dependency of execution
sequence for that device. I could have moved ->voltage_switch() call
at one common place (above/below), but was not quite sure about it.
So, replicated/duplicated the call for other voltages.


Vaibhav Hiremath (3):
  mmc: sdhci: pass signal_voltage as an argument to voltage_switch
    callback
  mmc: sdhci: add host_ops->voltage_switch callback for all other
    voltages
  mmc: sdhci-pxav3: Add ->voltage_switch callback support

 drivers/mmc/host/sdhci-pxav3.c   | 59 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c         | 10 ++++++-
 drivers/mmc/host/sdhci.h         |  2 +-
 drivers/mmc/host/sdhci_f_sdh30.c |  3 +-
 4 files changed, 71 insertions(+), 3 deletions(-)

-- 
1.9.1

