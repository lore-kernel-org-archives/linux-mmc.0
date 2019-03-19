From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3 1/2] mmc: sdhci: Make sdhci_send_command() public
Date: Tue, 19 Mar 2019 13:34:50 +0530
Message-ID: <1d9d2953-596c-f42f-10e0-dec94ccfda52@ti.com>
References: <20190319063533.12171-1-faiz_abbas@ti.com>
 <20190319063533.12171-2-faiz_abbas@ti.com>
 <53872d7f-9339-b288-4e48-a6164ee463c5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53872d7f-9339-b288-4e48-a6164ee463c5@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi Kishon,

On 19/03/19 1:28 PM, Kishon Vijay Abraham I wrote:
> Hi Faiz,
> 
> On 19/03/19 12:05 PM, Faiz Abbas wrote:
>> Make sdhci_send_command() public so that it can be called from platform
>> drivers.
> 
> This should be sdhci_finish_command here and also in subject
> How about using "mmc: sdhci: Export sdhci_finish_command()"?
>

My bad. Will update to "mmc: sdhci: Export sdhci_finish_command()" in
next version.

Thanks,
Faiz
