From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
Date: Mon, 20 May 2019 10:46:19 +0200
Message-ID: <36cae1d3-f11c-3c71-3f04-23fdc74f8866@broadcom.com>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org> <20190519090642.GA2279@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190519090642.GA2279@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Douglas Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-rockchip@lists.infradead.org, Double Lo <double.lo@cypress.com>, briannorris@chromium.org, Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Jiong Wu <lohengrin1024@gmail.com>, Ritesh Harjani <riteshh@codeaurora.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
List-Id: linux-mmc@vger.kernel.org

On 5/19/2019 11:06 AM, Wolfram Sang wrote:
> 
>> Let's add an API that the SDIO card drivers can call that will
>> temporarily disable the auto-tuning functionality.  Then we can add a
>> call to this in the Broadcom WiFi driver and any other driver that
>> might have similar needs.
> 
> Can't you fix the WiFi driver to return something else than -EILSEQ
> before calling mmc_request_done() to skip the retuning?

Not really. mmc_request_done() is for the host controller driver so the 
wifi driver is not involved.

Regards,
Arend
