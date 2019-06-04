From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 0/4] Add Support for MMC in J721E
Date: Tue, 4 Jun 2019 12:01:03 +0530
Message-ID: <93ba4b6d-c878-fe62-2835-366167554ef5@ti.com>
References: <20190604060914.10886-1-faiz_abbas@ti.com>
 <2f45cef2-c4ca-0404-b205-fabbb92a40fb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2f45cef2-c4ca-0404-b205-fabbb92a40fb@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: nm@ti.com, ulf.hansson@linaro.org, robh+dt@kernel.org, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On 04/06/19 11:48 AM, Sekhar Nori wrote:
> On 04/06/19 11:39 AM, Faiz Abbas wrote:
>> The following patches add driver support for MMC SDHCI interfaces on
>> TI's J721E devices. The 8 bit and 4 bit instances have phys which are
>> different from the am65x interfaces as well as different from each
>> other which leads to 3 different compatibles and a bunch of flags for
>> indicating the differences.
>>
>> Depends on Nishanth's initial J721E patches here:
>> https://lore.kernel.org/patchwork/cover/1077382/
> 
> This dependency is only for testing, not for applying these, right?
> 

Yes. The dependency is only for testing.

Thanks,
Faiz
