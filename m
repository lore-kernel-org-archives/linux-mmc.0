From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 1/2] mmc: omap_hsmmc: Add support for quirky omap3
 hsmmc controller
Date: Fri, 28 Feb 2014 09:09:26 -0600
Message-ID: <5310A6A6.6030803@ti.com>
References: <1392356749-32091-1-git-send-email-nm@ti.com>
 <1392356749-32091-2-git-send-email-nm@ti.com>
 <20140214163102.GA21592@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140214163102.GA21592@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>
Cc: devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 02/14/2014 10:31 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [140213 21:48]:
>> When device is booted using devicetree, platforms impacted by Erratum
>> 2.1.1.128 is not detected easily in the mmc driver. This erratum
>> indicates that the module cannot do multi-block transfers. Platforms
>> such as LDP which use OMAP3 ES revision prior to ES3.0 are impacted by
>> this.
>>
>> Provide a new compatible property "ti,omap3-pre-es3-hsmmc" to allow
>> driver to determine if driver needs to implement quirks associated
>> with the specific module version (primarily because the IP revision
>> information is not sufficient for the same).
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Looks good to me, would be good to get this into the -rc cycle
> as LDP is one of the automated boot testing boards for us.
> 
> If you guys want me to pick up both of the patches let me know,
> otherwise feel free to add my ack.
> 

Chris,
would you be picking up the series that fixes LDP dt boot behavior or
should Tony pick it up?

https://patchwork.kernel.org/patch/3650061/
https://patchwork.kernel.org/patch/3650031/


-- 
Regards,
Nishanth Menon
