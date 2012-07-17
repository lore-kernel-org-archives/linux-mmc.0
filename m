From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v3 5/6] mmc: dw_mmc: add device tree support
Date: Tue, 17 Jul 2012 15:49:58 +0530
Message-ID: <CAJuYYwTLxEgm3CnPof4ub=XQazJ+PaUG-zk14nGnpBwWsnHMvw@mail.gmail.com>
References: <1342097668-25243-1-git-send-email-thomas.abraham@linaro.org>
	<1342097668-25243-6-git-send-email-thomas.abraham@linaro.org>
	<CAGxe1ZHZr2=127p8X-A12K2-zOyKMOJ0fkx5pWNovVteFfSPwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZHZr2=127p8X-A12K2-zOyKMOJ0fkx5pWNovVteFfSPwg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 16 July 2012 09:45, Girish K S <girish.shivananjappa@linaro.org> wrote:
> On 12 July 2012 18:24, Thomas Abraham <thomas.abraham@linaro.org> wrote:

[...]

>>
>> +#ifdef CONFIG_OF
>> +static struct dw_mci_drv_data synopsis_drv_data = {
>> +       .ctrl_type      = DW_MCI_TYPE_SYNOPSIS,
>> +};
>> +
>> +static const struct of_device_id dw_mci_pltfm_match[] = {
>> +       { .compatible = "snps,dw-mshc",
>> +                       .data = (void *)&synopsis_drv_data, },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
>> +#else
>> +static const struct of_device_id dw_mci_pltfm_match[];
> the #else and a statement can be completely removed if of_match_ptr is
> used while accessing the dw_mci_pltfm_match in of_match_node function.
>> +#endif
>> +
>>  static int dw_mci_pltfm_probe(struct platform_device *pdev)
>>  {
>>         struct dw_mci *host;
>> @@ -51,6 +67,13 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
>>         if (!host->regs)
>>                 goto err_free;
>>         platform_set_drvdata(pdev, host);
>> +
>> +       if (pdev->dev.of_node) {
>> +               const struct of_device_id *match;
>> +               match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
> can be modified to of_match_node(of_match_pt(dw_mci_pltfm_match),
> pdev->dev.of_node);
> This will remove the dummy allocation of variable as mentioned above.
> Also it will be generic in non dt case.

Ok. Thanks for the suggestion. I will modify it as per your suggestion.

Thanks,
Thomas.

[...]
