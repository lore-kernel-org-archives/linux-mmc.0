From: =?UTF-8?Q?David_M=c3=bcller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>
Subject: Re: "Card stuck in programming state! __mmc_switch" problem
 on i.MX6 + eMMC
Date: Wed, 17 Sep 2014 09:45:57 +0200
Message-ID: <54193C35.8060104@elsoft.ch>
References: <54184B19.4080909@elsoft.ch> <CAL8zT=hahrDA++0Y3K=m5XXvwRBNRyfW2NWfQWjFV0cg6sHS2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.hostpark.net ([212.243.197.30]:42424 "EHLO
	mail.hostpark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbaIQHpr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Sep 2014 03:45:47 -0400
In-Reply-To: <CAL8zT=hahrDA++0Y3K=m5XXvwRBNRyfW2NWfQWjFV0cg6sHS2A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Jean-Michel

Jean-Michel Hautbois wrote:
> Can you show your DT (at least pinmux part and usdhc3 node) ?

	pinctrl_usdhc3: usdhc3grp {
		fsl,pins = <
			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x1b0b1
			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100b1
			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x1b0b1
			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x1b0b1
			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x1b0b1
			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x1b0b1
			MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x1b0b1
			MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x1b0b1
			MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x1b0b1
			MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x1b0b1
			MX6QDL_PAD_SD3_RST__SD3_RESET  0x1b070
		>;
	};

&usdhc3 { /* eMMC */
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usdhc3>;
	vmmc-supply = <&reg_3v15>;
	non-removable;
	no-1-8-v;
	bus-width = <8>;
	status = "okay";
};


I've tracked the problem down to the point were the MMC code tries to
switch the eMMC to 8bit bus width (mmc_select_bus_width()).

