From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V2 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm
Date: Mon, 12 Feb 2018 11:31:16 +0530
Message-ID: <1518415278-59062-1-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, vviswana@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

>From the HPG:
In some platform, SDCC controller can be connected to either an eMMC device or
an SD card. The PADs for SD card are dual-voltage that support 3v/1.8v. Those
PADs have a control signal  (io_pad_pwr_switch/mode18 ) that indicates whether
the PAD works in 3v or 1.8v.

For SD usage the default value of this signal is ‘0’, and SD driver changes it
to ‘1’ as a part of voltage switching sequence.
For eMMC usage, SW should configure this signal to ‘1’ and supply 1.8v to PADs
before starting any activity on the eMMC BUS.

To set this signal, write the following in the
SDC1_SDCC_HC_VENDOR_SPECIFIC_FUNC register:
	HC_IO_PAD_PWR_SWITCH: bit 16
	HC_IO_PAD_PWR_SWITCH_EN: bit 15

Changes since v1:
	Modified comments on io_pad related changes.
	Split some read+modify+write commands to multiple lines

Krishna Konda (1):
  mmc: sdhci-msm: support voltage pad switching

Vijay Viswanath (1):
  mmc: sdhci-msm: Add support to store supported vdd-io voltages

 drivers/mmc/host/sdhci-msm.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
